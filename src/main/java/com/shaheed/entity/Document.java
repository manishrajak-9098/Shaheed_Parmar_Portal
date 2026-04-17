package com.shaheed.entity;

import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "documents")
public class Document {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    
    
    @Column(name = "aadhaar_path")
    private String aadhaarPath;

    @Column(name = "army_id_path")
    private String armyIdPath;

    @Column(name = "certificate_path")
    private String certificatePath;

    @Column(name = "family_proof_path")
    private String familyProofPath;

    @Column(name = "shaheed_photo_path")
    private String shaheedPhotoPath;

    @Column(name = "family_id")
    private Long familyId;

    @Column(name = "shaheed_id")
    private Long shaheedId;

 // Document.java mein
    @org.hibernate.annotations.CreationTimestamp // Ye automatically insert ke waqt date daal dega
    @Column(name = "upload_date", updatable = false) // updatable=false taaki purani date change na ho
    private java.sql.Timestamp uploadDate;

    // ── Associations ──
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_id", insertable = false, updatable = false)
    private FamilyUser familyRef;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "shaheed_id", insertable = false, updatable = false)
    private Shaheed shaheedRef;

    // ── Getters & Setters ──
    public Long getId()                          { return id; }
    public void setId(Long id)                   { this.id = id; }
    public String getAadhaarPath()               { return aadhaarPath; }
    public void setAadhaarPath(String a)         { this.aadhaarPath = a; }
    public String getArmyIdPath()                { return armyIdPath; }
    public void setArmyIdPath(String a)          { this.armyIdPath = a; }
    public String getCertificatePath()           { return certificatePath; }
    public void setCertificatePath(String c)     { this.certificatePath = c; }
    public String getFamilyProofPath()           { return familyProofPath; }
    public void setFamilyProofPath(String f)     { this.familyProofPath = f; }
    public String getShaheedPhotoPath()          { return shaheedPhotoPath; }
    public void setShaheedPhotoPath(String s)    { this.shaheedPhotoPath = s; }
    public Long getFamilyId()                    { return familyId; }
    public void setFamilyId(Long f)              { this.familyId = f; }
    public Long getShaheedId()                   { return shaheedId; }
    public void setShaheedId(Long s)             { this.shaheedId = s; }
    public Timestamp getUploadDate()             { return uploadDate; }
    public void setUploadDate(Timestamp t)       { this.uploadDate = t; }
    public FamilyUser getFamilyRef()                { return familyRef; }
    public void setFamilyRef(FamilyUser familyRef)  { this.familyRef = familyRef; }
    public Shaheed getShaheedRef()                  { return shaheedRef; }
    public void setShaheedRef(Shaheed shaheedRef)   { this.shaheedRef = shaheedRef; }
}