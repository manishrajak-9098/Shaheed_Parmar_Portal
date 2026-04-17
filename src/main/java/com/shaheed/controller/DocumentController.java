package com.shaheed.controller;

import com.shaheed.entity.*;
import com.shaheed.service.*;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.Map;

@Controller
public class DocumentController {

    @Autowired private DocumentService documentService;
    @Autowired private ApplicationService applicationService;
    
    // Cloudinary bean ko inject karein (Iska config humne pehle banaya tha)
    @Autowired private Cloudinary cloudinary;

    @GetMapping("/uploadDocuments")
    public String uploadPage(HttpSession session, Model model) {
        FamilyUser user = (FamilyUser) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";
        try {
            model.addAttribute("existingDoc", documentService.findByFamilyId(user.getId()));
        } catch (Exception e) { 
            model.addAttribute("existingDoc", null); 
        }
        return "upload-document";
    }

    @PostMapping("/uploadDocuments")
    public String uploadDocs(
            @RequestParam("aadhaar") MultipartFile aadhaar,
            @RequestParam("armyId") MultipartFile armyId,
            @RequestParam("certificate") MultipartFile certificate,
            @RequestParam("familyProof") MultipartFile familyProof,
            @RequestParam("photo") MultipartFile photo,
            HttpSession session, Model model) {

        FamilyUser user = (FamilyUser) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        try {
            Document existing = null;
            try {
                existing = documentService.findByFamilyId(user.getId());
            } catch (Exception ignored) {}

            Document doc = (existing != null) ? existing : new Document();
            doc.setFamilyId(user.getId());
            
            Long shaheedId = (Long) session.getAttribute("savedShaheedId");
            if (shaheedId == null) {
                shaheedId = doc.getShaheedId();
            }
            if (shaheedId != null) doc.setShaheedId(shaheedId);

            // Cloudinary Upload Logic
            // Har file ke liye hum uploadToCloudinary method call karenge
            
            if (!aadhaar.isEmpty()) {
                doc.setAadhaarPath(uploadToCloudinary(aadhaar));
            }
            
            if (!armyId.isEmpty()) {
                doc.setArmyIdPath(uploadToCloudinary(armyId));
            }
            
            if (!certificate.isEmpty()) {
                doc.setCertificatePath(uploadToCloudinary(certificate));
            }
            
            if (!familyProof.isEmpty()) {
                doc.setFamilyProofPath(uploadToCloudinary(familyProof));
            }
            
            if (!photo.isEmpty()) {
                doc.setShaheedPhotoPath(uploadToCloudinary(photo));
            }

            Document savedDoc = documentService.save(doc);

            if (applicationService.findByFamilyUserId(user.getId()) == null) {
                Application app = new Application();
                app.setFamilyUserId(user.getId()); 
                app.setShaheedId(shaheedId);
                app.setDocumentId(savedDoc.getId()); 
                app.setVerificationStatus("PENDING");
                applicationService.save(app);
            }
            
            return "redirect:/dashboard?uploaded=true";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Cloudinary Upload failed: " + e.getMessage());
            return "upload-document";
        }
    }

    // Ek helper method jo file ko Cloudinary par upload karke uska URL return karega
    private String uploadToCloudinary(MultipartFile file) throws IOException {
        Map uploadResult = cloudinary.uploader().upload(file.getBytes(), 
            ObjectUtils.asMap("resource_type", "auto")); // auto allows PDF and Images
        return uploadResult.get("secure_url").toString();
    }
}