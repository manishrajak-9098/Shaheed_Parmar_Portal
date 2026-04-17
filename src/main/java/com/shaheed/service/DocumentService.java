package com.shaheed.service;
import com.shaheed.entity.Document;
public interface DocumentService {
    Document save(Document doc);
    Document findByFamilyId(Long familyId);
}