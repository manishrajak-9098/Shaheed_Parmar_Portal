package com.shaheed.controller;

import com.shaheed.entity.FamilyUser;
import com.shaheed.service.FamilyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.sql.Date;

@Controller
public class AuthController {

    @Autowired
    private FamilyService familyService;

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/about")
    public String about() {
        return "about";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(
            @ModelAttribute FamilyUser user,
            Model model) {

        if (user.getName() == null || user.getName().trim().isEmpty()) {
            model.addAttribute("error", "Full name is required.");
            return "register";
        }
        
        
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (user.getEmail() == null || !user.getEmail().matches(emailRegex)) {
            model.addAttribute("error", "Invalid Email format.");
            return "register";
        }

        
        String passRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$";
        if (user.getPassword() == null || !user.getPassword().matches(passRegex)) {
            model.addAttribute("error", "Password must be at least 8 chars with 1 Upper, 1 Digit, and 1 Special char.");
            return "register";
        }

       
        if (user.getDob() != null && !user.getDob().toString().isEmpty()) {
            try {
                Date dob = Date.valueOf(user.getDob().toString());
                Date today = new Date(System.currentTimeMillis());
                if (dob.after(today)) {
                    model.addAttribute("error", "Date of Birth cannot be in the future.");
                    return "register";
                }
            } catch (Exception e) {  }
        }

        try {
            user.setStatus("PENDING");
            familyService.register(user);
            return "redirect:/login?registered=true";
        } catch (Exception e) {
            model.addAttribute("error", "Registration failed. Email may already be registered.");
            return "register";
        }
    }

    @GetMapping("/login")
    public String loginPage(
            @RequestParam(value = "registered", required = false) String registered,
            @RequestParam(value = "logout",     required = false) String logout,
            HttpSession session,
            Model model) {

        if (session.getAttribute("loggedUser") != null) {
            return "redirect:/dashboard";
        }

        if ("true".equals(registered))
            model.addAttribute("success", "Registration successful! Please login.");
        if ("true".equals(logout))
            model.addAttribute("info", "You have been logged out successfully.");

        return "login";
    }

    @PostMapping("/login")
    public String loginSubmit(
            @RequestParam("email")    String email,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Email and Password are required.");
            return "login";
        }

        try {
            FamilyUser user = familyService.login(email.trim(), password);
            if (user != null) {
                session.removeAttribute("loggedAdmin"); 
                
                session.setAttribute("loggedUser", user);
                session.setAttribute("userId", user.getId());
                return "redirect:/dashboard";
            }
            model.addAttribute("error", "Invalid Email or Password.");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "Login failed.");
            return "login";
        }
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout=true";
    }
}