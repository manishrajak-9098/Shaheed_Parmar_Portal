package com.shaheed.controller;
import com.shaheed.entity.FamilyUser;
import com.shaheed.entity.Shaheed;
import com.shaheed.service.ShaheedService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
@Controller
public class ShaheedController {

@Autowired
private ShaheedService shaheedService;

@GetMapping("/shaheedDetails")
public String shaheedForm(HttpSession session, Model model) {
    FamilyUser user = (FamilyUser) session.getAttribute("loggedUser");
    if (user == null) return "redirect:/login";

    try {
        Shaheed existing = shaheedService.findByFamilyUserId(user.getId());
        model.addAttribute("shaheed", existing);
    } catch (Exception e) {
        model.addAttribute("shaheed", null);
    }

    return "shaheed-details";
}

@PostMapping("/saveShaheed")
public String saveShaheed(
        @ModelAttribute Shaheed shaheed,
        HttpSession session,
        Model model) {

    FamilyUser user = (FamilyUser) session.getAttribute("loggedUser");
    if (user == null) return "redirect:/login";

    if (shaheed.getName() == null || shaheed.getName().trim().isEmpty()) {
        model.addAttribute("error", "Shaheed name is required.");
        model.addAttribute("shaheed", shaheed);
        return "shaheed-details";
    }
    if (shaheed.getServiceNumber() == null
            || shaheed.getServiceNumber().trim().isEmpty()) {
        model.addAttribute("error", "Service number is required.");
        model.addAttribute("shaheed", shaheed);
        return "shaheed-details";
    }

    try {
        shaheed.setFamilyUserId(user.getId());
        Shaheed saved = shaheedService.save(shaheed);
        session.setAttribute("savedShaheedId", saved.getId());
        return "redirect:/uploadDocuments";
    } catch (Exception e) {
        model.addAttribute("error", "Save failed: " + e.getMessage());
        model.addAttribute("shaheed", shaheed);
        return "shaheed-details";
    }
}
}