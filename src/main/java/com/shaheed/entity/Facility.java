package com.shaheed.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "facility")
public class Facility {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "facility_type")
    private String facilityType;

    // ── Associations ──
    @OneToMany(mappedBy = "facilityRef", fetch = FetchType.LAZY)
    private List<FacilityAllocation> facilityAllocations;

    // ── Getters & Setters ──
    public Long getId()                        { return id; }
    public void setId(Long id)                 { this.id = id; }
    public String getName()                    { return name; }
    public void setName(String name)           { this.name = name; }
    public String getDescription()             { return description; }
    public void setDescription(String d)       { this.description = d; }
    public String getFacilityType()            { return facilityType; }
    public void setFacilityType(String t)      { this.facilityType = t; }

    public List<FacilityAllocation> getFacilityAllocations()          { return facilityAllocations; }
    public void setFacilityAllocations(List<FacilityAllocation> list) { this.facilityAllocations = list; }
}