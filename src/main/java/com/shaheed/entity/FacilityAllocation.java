package com.shaheed.entity;

import jakarta.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;

@Entity
@Table(name = "facility_allocation")
public class FacilityAllocation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "application_id")
    private Long applicationId;

    @Column(name = "family_user_id")
    private Long familyUserId;

    @Column(name = "facility_id")
    private Long facilityId;

    @Column(name = "start_date")
    private Date startDate;

    @Column(name = "remarks")
    private String remarks;

    @Column(name = "status")
    private String status;

    @Column(name = "allocated_by")
    private Long allocatedBy;

    @Column(name = "allocated_date", insertable = false, updatable = false)
    private Timestamp allocatedDate;

    // ── Associations ──
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "application_id", insertable = false, updatable = false)
    private Application applicationRef;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_user_id", insertable = false, updatable = false)
    private FamilyUser familyUserRef;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "facility_id", insertable = false, updatable = false)
    private Facility facilityRef;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "allocated_by", insertable = false, updatable = false)
    private Admin allocatedByRef;

    // ── Getters & Setters ──
    public Long getId()                          { return id; }
    public void setId(Long id)                   { this.id = id; }
    public Long getApplicationId()               { return applicationId; }
    public void setApplicationId(Long a)         { this.applicationId = a; }
    public Long getFamilyUserId()                { return familyUserId; }
    public void setFamilyUserId(Long f)          { this.familyUserId = f; }
    public Long getFacilityId()                  { return facilityId; }
    public void setFacilityId(Long f)            { this.facilityId = f; }
    public Date getStartDate()                   { return startDate; }
    public void setStartDate(Date d)             { this.startDate = d; }
    public String getRemarks()                   { return remarks; }
    public void setRemarks(String r)             { this.remarks = r; }
    public String getStatus()                    { return status; }
    public void setStatus(String s)              { this.status = s; }
    public Long getAllocatedBy()                  { return allocatedBy; }
    public void setAllocatedBy(Long a)           { this.allocatedBy = a; }
    public Timestamp getAllocatedDate()           { return allocatedDate; }
    public void setAllocatedDate(Timestamp t)    { this.allocatedDate = t; }

    public Application getApplicationRef()                   { return applicationRef; }
    public void setApplicationRef(Application applicationRef){ this.applicationRef = applicationRef; }
    public FamilyUser getFamilyUserRef()                     { return familyUserRef; }
    public void setFamilyUserRef(FamilyUser familyUserRef)   { this.familyUserRef = familyUserRef; }
    public Facility getFacilityRef()                         { return facilityRef; }
    public void setFacilityRef(Facility facilityRef)         { this.facilityRef = facilityRef; }
    public Admin getAllocatedByRef()                          { return allocatedByRef; }
    public void setAllocatedByRef(Admin allocatedByRef)      { this.allocatedByRef = allocatedByRef; }
}