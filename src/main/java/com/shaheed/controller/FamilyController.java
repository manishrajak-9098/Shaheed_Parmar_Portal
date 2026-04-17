package com.shaheed.controller;

import com.shaheed.entity.*;
import com.shaheed.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class FamilyController {

    @Autowired private ApplicationService        applicationService;
    @Autowired private ShaheedService            shaheedService;
    @Autowired private DocumentService           documentService;
    @Autowired private FacilityAllocationService facilityAllocationService;
    @Autowired private FacilityService           facilityService;
    @Autowired private FamilyService             familyService;

    private FamilyUser getLoggedUser(HttpSession session) {
        Object obj = session.getAttribute("loggedUser");
        if (obj instanceof FamilyUser) {
            return (FamilyUser) obj;
        }
        return null;
    }

    /* ─ DASHBOARD ─ */
    @GetMapping("/dashboard")
    public String dashboard(
            HttpSession session,
            Model model,
            @RequestParam(value = "uploaded", required = false) String uploaded) {

        FamilyUser user = getLoggedUser(session);
        if (user == null) return "redirect:/login";

        try {
            user = familyService.findById(user.getId());
            if (user == null) {
                session.invalidate();
                return "redirect:/login";
            }
            session.setAttribute("loggedUser", user);

            Application app =
                applicationService.findByFamilyUserId(user.getId());
            Shaheed shaheed =
                shaheedService.findByFamilyUserId(user.getId());
            Document doc =
                documentService.findByFamilyId(user.getId());
            List<FacilityAllocation> allocations =
                facilityAllocationService.getByFamilyUserId(user.getId());
            List<Facility> facilities =
                facilityService.getAll();

            model.addAttribute("user",        user);
            model.addAttribute("application", app);
            model.addAttribute("shaheed",     shaheed);
            model.addAttribute("document",    doc);
            model.addAttribute("allocations", allocations);
            model.addAttribute("facilities",  facilities);

            if ("true".equals(uploaded))
                model.addAttribute("success",
                    "Documents uploaded! Application submitted for admin review.");

        } catch (Exception e) {
            model.addAttribute("error", "Error loading dashboard: " + e.getMessage());
        }

        return "dashboard";
    }

    /* ── MY STATUS ── */
    @GetMapping("/my-status")
    public String myStatus(HttpSession session, Model model) {
        FamilyUser user = getLoggedUser(session);
        if (user == null) return "redirect:/login";

        try {
            Application app =
                applicationService.findByFamilyUserId(user.getId());
            List<FacilityAllocation> allocations =
                facilityAllocationService.getByFamilyUserId(user.getId());
            List<Facility> facilities =
                facilityService.getAll();
            Shaheed shaheed =
                shaheedService.findByFamilyUserId(user.getId());

            model.addAttribute("user",        user);
            model.addAttribute("application", app);
            model.addAttribute("allocations", allocations);
            model.addAttribute("facilities",  facilities);
            model.addAttribute("shaheed",     shaheed);
        } catch (Exception e) {
            model.addAttribute("error", "Error loading status: " + e.getMessage());
        }

        return "status";
    }

    /* ── PROFILE GET ── */
    @GetMapping("/profile")
    public String profilePage(HttpSession session, Model model) {
        FamilyUser user = getLoggedUser(session);
        if (user == null) return "redirect:/login";
        model.addAttribute("user", user);
        return "profile";
    }

    /* ── PROFILE UPDATE--- */
    @PostMapping("/profile/update")
    public String updateProfile(
            @ModelAttribute FamilyUser updated,
            HttpSession session,
            Model model) {

        FamilyUser user = getLoggedUser(session);
        if (user == null) return "redirect:/login";

        updated.setId(user.getId());
        updated.setEmail(user.getEmail());
        updated.setStatus(user.getStatus());

        // Validation
        if (updated.getName() == null || updated.getName().trim().isEmpty()) {
            model.addAttribute("error", "Name cannot be empty.");
            model.addAttribute("user", user);
            return "profile";
        }
        if (updated.getMobile() != null
                && !updated.getMobile().trim().isEmpty()
                && !updated.getMobile().matches("\\d{10}")) {
            model.addAttribute("error", "Mobile must be 10 digits.");
            model.addAttribute("user", user);
            return "profile";
        }

        try {
            familyService.update(updated);
            FamilyUser refreshed = familyService.findById(user.getId());
            session.setAttribute("loggedUser", refreshed);
            model.addAttribute("success", "Profile updated successfully!");
            model.addAttribute("user", refreshed);
        } catch (Exception e) {
            model.addAttribute("error", "Update failed: " + e.getMessage());
            model.addAttribute("user", user);
        }

        return "profile";
    }
}