package com.shaheed.controller;

import com.shaheed.entity.Feedback;
import com.shaheed.service.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class FeedbackController {

    @Autowired
    private FeedbackService feedbackService;

    @GetMapping("/feedback")
    public String feedbackPage() {
        return "feedback";
    }

    @PostMapping("/feedback")
    public String submitFeedback(
            @ModelAttribute Feedback feedback,
            Model model) {

        if (feedback.getName() == null
                || feedback.getName().trim().isEmpty()
                || feedback.getMessage() == null
                || feedback.getMessage().trim().isEmpty()) {
            model.addAttribute("error", "Name and Message are required.");
            return "feedback";
        }

        try {
            feedbackService.save(feedback);
            model.addAttribute("success",
                    "Thank you! Your feedback has been submitted.");
        } catch (Exception e) {
            model.addAttribute("error",
                    "Could not submit feedback. Please try again.");
        }

        return "feedback";
    }
}