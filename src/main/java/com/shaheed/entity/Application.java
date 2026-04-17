package com.shaheed.entity;

import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "application")
public class Application {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "family_user_id")
    private Long familyUserId;

    @Column(name = "shaheed_id")
    private Long shaheedId;

    @Column(name = "document_id")
    private Long documentId;

    @Column(name = "submission_date", insertable = false, updatable = false)
    private Timestamp submissionDate;

    @Column(name = "verification_status")
    private String verificationStatus;

    @Column(name = "admin_remarks")
    private String adminRemarks;

    @Column(name = "verified_by_admin")
    private Long verifiedByAdmin;

    @Column(name = "verified_date")
    private Timestamp verifiedDate;

    // ── Associations ──
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_user_id", insertable = false, updatable = false)
    private FamilyUser familyUserRef;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "shaheed_id", insertable = false, updatable = false)
    private Shaheed shaheedRef;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "verified_by_admin", insertable = false, updatable = false)
    private Admin verifiedByAdminRef;

    @OneToOne(mappedBy = "applicationRef", fetch = FetchType.LAZY)
    private FacilityAllocation facilityAllocation;

    // ── Getters & Setters ──
    public Long getId()                          { return id; }
    public void setId(Long id)                   { this.id = id; }
    public Long getFamilyUserId()                { return familyUserId; }
    public void setFamilyUserId(Long f)          { this.familyUserId = f; }
    public Long getShaheedId()                   { return shaheedId; }
    public void setShaheedId(Long s)             { this.shaheedId = s; }
    public Long getDocumentId()                  { return documentId; }
    public void setDocumentId(Long d)            { this.documentId = d; }
    public Timestamp getSubmissionDate()         { return submissionDate; }
    public void setSubmissionDate(Timestamp t)   { this.submissionDate = t; }
    public String getVerificationStatus()        { return verificationStatus; }
    public void setVerificationStatus(String v)  { this.verificationStatus = v; }
    public String getAdminRemarks()              { return adminRemarks; }
    public void setAdminRemarks(String r)        { this.adminRemarks = r; }
    public Long getVerifiedByAdmin()             { return verifiedByAdmin; }
    public void setVerifiedByAdmin(Long v)       { this.verifiedByAdmin = v; }
    public Timestamp getVerifiedDate()           { return verifiedDate; }
    public void setVerifiedDate(Timestamp t)     { this.verifiedDate = t; }

    public FamilyUser getFamilyUserRef()                        { return familyUserRef; }
    public void setFamilyUserRef(FamilyUser familyUserRef)      { this.familyUserRef = familyUserRef; }
    public Shaheed getShaheedRef()                              { return shaheedRef; }
    public void setShaheedRef(Shaheed shaheedRef)               { this.shaheedRef = shaheedRef; }
    public Admin getVerifiedByAdminRef()                        { return verifiedByAdminRef; }
    public void setVerifiedByAdminRef(Admin verifiedByAdminRef) { this.verifiedByAdminRef = verifiedByAdminRef; }
    public FacilityAllocation getFacilityAllocation()           { return facilityAllocation; }
    public void setFacilityAllocation(FacilityAllocation fa)    { this.facilityAllocation = fa; }
}