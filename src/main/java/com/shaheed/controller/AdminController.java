package com.shaheed.controller;

import com.shaheed.entity.*;
import com.shaheed.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private AdminService              adminService;
    @Autowired private ApplicationService        applicationService;
    @Autowired private FamilyService             familyService;
    @Autowired private ShaheedService            shaheedService;
    @Autowired private FacilityService           facilityService;
    @Autowired private FacilityAllocationService allocationService;
    @Autowired private FeedbackService           feedbackService;
    @Autowired private DocumentService           documentService; 

    private Admin getAdmin(HttpSession session) {
        Object obj = session.getAttribute("loggedAdmin");
        if (obj instanceof Admin) return (Admin) obj;
        return null;
    }

    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "logout", required = false) String logout, HttpSession session, Model model) {
        if (getAdmin(session) != null) return "redirect:/admin/dashboard";
        if ("true".equals(logout)) model.addAttribute("info", "Logged out successfully.");
        return "admin-login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {

        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Username and Password are required.");
            return "admin-login";
        }

        try {
            Admin admin = adminService.login(username.trim(), password);
            if (admin != null) {
               
                session.removeAttribute("loggedUser");
                session.removeAttribute("userId");
                
                session.setAttribute("loggedAdmin", admin);
                return "redirect:/admin/dashboard";
            }
            model.addAttribute("error", "Invalid credentials. Please try again.");
        } catch (Exception e) {
            model.addAttribute("error", "Login error: " + e.getMessage());
        }

        return "admin-login";
    }
    @GetMapping("/logout")
    public String logout(HttpSession session, jakarta.servlet.http.HttpServletResponse response) {
        session.removeAttribute("loggedAdmin");
        session.invalidate();
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        return "redirect:/admin/login?logout=true";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model, jakarta.servlet.http.HttpServletResponse response) {
        if (getAdmin(session) == null) return "redirect:/admin/login";
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        try {
            model.addAttribute("totalApps", applicationService.countAll());
            model.addAttribute("pendingCount", applicationService.countByStatus("PENDING"));
            model.addAttribute("verifiedCount", applicationService.countByStatus("VERIFIED"));
            model.addAttribute("rejectedCount", applicationService.countByStatus("REJECTED"));
            model.addAttribute("totalFamilies", familyService.getAll().size());
            model.addAttribute("totalShaheeds", shaheedService.getAll().size());
            model.addAttribute("recentApps", applicationService.getAll());
            model.addAttribute("families", familyService.getAll());
            model.addAttribute("shaheeds", shaheedService.getAll());
            model.addAttribute("allAllocations", allocationService.getAll());
            model.addAttribute("facilities", facilityService.getAll());
        } catch (Exception e) { model.addAttribute("error", "Dashboard error."); }
        return "admin-dashboard";
    }

    @GetMapping("/families")
    public String allRegisteredFamilies(HttpSession session, Model model) {
        if (getAdmin(session) == null) return "redirect:/admin/login";
        try {
            model.addAttribute("families", familyService.getAll());
        } catch (Exception e) { model.addAttribute("families", new ArrayList<>()); }
        return "admin-families";
    }

    @GetMapping("/feedback")
    public String viewFeedback(HttpSession session, Model model) {
        if (getAdmin(session) == null) return "redirect:/admin/login";
        model.addAttribute("feedbacks", feedbackService.getAll());
        return "admin-feedback";
    }

    @GetMapping("/verification")
    public String verification(HttpSession session, Model model, @RequestParam(value = "msg", required = false) String msg) {
        if (getAdmin(session) == null) return "redirect:/admin/login";
        model.addAttribute("applications", applicationService.getByStatus("PENDING"));
        model.addAttribute("families", familyService.getAll());
        model.addAttribute("shaheeds", shaheedService.getAll());
        if (msg != null) model.addAttribute("msg", "Marked as " + msg.toUpperCase());
        return "admin-verification";
    }

    
    @PostMapping("/verify")
    public String verifyApp(@RequestParam("appId") Long appId, @RequestParam("action") String action, @RequestParam(value = "remarks", defaultValue = "") String remarks, HttpSession session) {
        if (getAdmin(session) == null) return "redirect:/admin/login";
        try {
            Admin admin = getAdmin(session);
            String status = "VERIFY".equalsIgnoreCase(action) ? "VERIFIED" : "REJECTED";
            applicationService.verify(appId, status, remarks, admin.getId());
            
            if ("VERIFIED".equals(status)) {
                Application app = applicationService.findById(appId);
                FamilyUser family = familyService.findById(app.getFamilyUserId());
                if(family != null) {
                    family.setStatus("ACTIVE"); // Fix: Update to ACTIVE
                    familyService.update(family);
                }
            }
            return "redirect:/admin/verification?msg=" + status.toLowerCase();
        } catch (Exception e) { return "redirect:/admin/verification?msg=error"; }
    }

    @GetMapping("/applications")
    public String allApplications(HttpSession session, Model model) {
        if (getAdmin(session) == null) return "redirect:/admin/login";
        model.addAttribute("applications", applicationService.getAll());
        model.addAttribute("families", familyService.getAll());
        model.addAttribute("shaheeds", shaheedService.getAll());
        return "admin-all-applications";
    }

    @GetMapping("/shaheeds")
    public String shaheedRecords(HttpSession session, Model model) {
        if (getAdmin(session) == null) return "redirect:/admin/login";
        model.addAttribute("shaheeds", shaheedService.getAll());
        return "admin-shaheeds";
    }

    @GetMapping("/allocate/{appId}")
    public String allocateForm(@PathVariable("appId") Long appId, HttpSession session, Model model) {
        if (getAdmin(session) == null) return "redirect:/admin/login";
        try {
            Application app = applicationService.findById(appId);
            model.addAttribute("application", app);
            model.addAttribute("facilities", facilityService.getAll());
            model.addAttribute("existingAllocations", allocationService.getByApplicationId(appId));
            model.addAttribute("family", familyService.findById(app.getFamilyUserId()));
            model.addAttribute("shaheed", app.getShaheedId() != null ? shaheedService.findById(app.getShaheedId()) : null);
        } catch (Exception e) { return "redirect:/admin/applications"; }
        return "facility-allocation";
    }

    @PostMapping("/allocate")
    public String allocateFacility(@RequestParam("appId") Long appId,
    		@RequestParam("facilityId") Long facilityId,
    		@RequestParam(value = "startDate",
    		required = false) String startDate,
    		@RequestParam(value = "remarks",
    		required = false) String remarks, 
    		HttpSession session){
    	
               if (getAdmin(session) == null) return "redirect:/admin/login";
		            try {
		            Admin admin = getAdmin(session);
		            Application app = applicationService.findById(appId);
		            FacilityAllocation fa = new FacilityAllocation();
		            fa.setApplicationId(appId); fa.setFamilyUserId(app.getFamilyUserId()); fa.setFacilityId(facilityId);
		            fa.setRemarks(remarks); fa.setStatus("ACTIVE"); fa.setAllocatedBy(admin.getId());
		            if (startDate != null && !startDate.isEmpty()) fa.setStartDate(Date.valueOf(startDate));
		            allocationService.save(fa);
		            return "redirect:/admin/allocate/" + appId + "?success=true";
		               } catch (Exception e) {
		        	return "redirect:/admin/applications";
		        	}
         }

    @GetMapping("/allocations")
    public String allAllocations(HttpSession session, Model model) {
        if (getAdmin(session) == null) return "redirect:/admin/login";
        model.addAttribute("allocations", allocationService.getAll());
        model.addAttribute("families", familyService.getAll());
        model.addAttribute("facilities", facilityService.getAll());
        return "admin-allocations";
    }

   
    @GetMapping("/family/{id}")
    public String familyDetail(@PathVariable("id") Long id, HttpSession session, Model model) {
        if (getAdmin(session) == null) return "redirect:/admin/login";
        try {
            FamilyUser family = familyService.findById(id);
            Application app = applicationService.findByFamilyUserId(id);
            Shaheed shaheed = shaheedService.findByFamilyUserId(id);
            Document doc = documentService.findByFamilyId(id); 

            model.addAttribute("family", family);
            model.addAttribute("app", app);
            model.addAttribute("shaheed", shaheed);
            model.addAttribute("doc", doc); 
            model.addAttribute("allocs", allocationService.getByFamilyUserId(id));
            model.addAttribute("facilities", facilityService.getAll());
        } catch (Exception e) { return "redirect:/admin/applications"; }
        return "admin-family-detail";
    }
}