package com.shaheed.entity;

import jakarta.persistence.*;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name = "admin")
public class Admin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "username", nullable = false, unique = true)
    private String username;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "role")
    private String role;

    @Column(name = "created_at", insertable = false, updatable = false)
    private Timestamp createdAt;

    // ── Associations ──
    @OneToMany(mappedBy = "verifiedByAdminRef", fetch = FetchType.LAZY)
    private List<Application> verifiedApplications;

    @OneToMany(mappedBy = "allocatedByRef", fetch = FetchType.LAZY)
    private List<FacilityAllocation> facilityAllocations;

    // ── Getters & Setters ──
    public Long getId()                      { return id; }
    public void setId(Long id)               { this.id = id; }
    public String getUsername()              { return username; }
    public void setUsername(String u)        { this.username = u; }
    public String getPassword()              { return password; }
    public void setPassword(String p)        { this.password = p; }
    public String getFullName()              { return fullName; }
    public void setFullName(String f)        { this.fullName = f; }
    public String getRole()                  { return role; }
    public void setRole(String role)         { this.role = role; }
    public Timestamp getCreatedAt()          { return createdAt; }
    public void setCreatedAt(Timestamp t)    { this.createdAt = t; }

    public List<Application> getVerifiedApplications()             { return verifiedApplications; }
    public void setVerifiedApplications(List<Application> list)    { this.verifiedApplications = list; }
    public List<FacilityAllocation> getFacilityAllocations()       { return facilityAllocations; }
    public void setFacilityAllocations(List<FacilityAllocation> l) { this.facilityAllocations = l; }
}