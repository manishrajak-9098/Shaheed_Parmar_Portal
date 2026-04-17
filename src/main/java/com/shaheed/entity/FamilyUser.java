package com.shaheed.entity;

import jakarta.persistence.*;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name = "family_user")
public class FamilyUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "dob")
    private String dob;

    @Column(name = "gender")
    private String gender;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "mobile")
    private String mobile;

    @Column(name = "aadhaar_number")
    private String aadhaarNumber;

    @Column(name = "relation_with_shaheed")
    private String relationWithShaheed;

    @Column(name = "marital_status")
    private String maritalStatus;

    @Column(name = "occupation")
    private String occupation;

    @Column(name = "address_line")
    private String addressLine;

    @Column(name = "city")
    private String city;

    @Column(name = "state")
    private String state;

    @Column(name = "pincode")
    private String pincode;

    @Column(name = "status")
    private String status;

    @Column(name = "registered_date", insertable = false, updatable = false)
    private Timestamp registeredDate;

    // ── Associations ──
    @OneToMany(mappedBy = "familyUserRef", fetch = FetchType.LAZY)
    private List<Shaheed> shaheeds;

    @OneToMany(mappedBy = "familyUserRef", fetch = FetchType.LAZY)
    private List<Application> applications;

    @OneToMany(mappedBy = "familyRef", fetch = FetchType.LAZY)
    private List<Document> documents;

    @OneToMany(mappedBy = "familyUserRef", fetch = FetchType.LAZY)
    private List<FacilityAllocation> facilityAllocations;

    @OneToMany(mappedBy = "familyUserRef", fetch = FetchType.LAZY)
    private List<Feedback> feedbacks;

    // ── Getters & Setters ──
    public Long getId()                           { return id; }
    public void setId(Long id)                    { this.id = id; }
    public String getName()                       { return name; }
    public void setName(String name)              { this.name = name; }
    public String getDob()                        { return dob; }
    public void setDob(String dob)                { this.dob = dob; }
    public String getGender()                     { return gender; }
    public void setGender(String gender)          { this.gender = gender; }
    public String getEmail()                      { return email; }
    public void setEmail(String email)            { this.email = email; }
    public String getPassword()                   { return password; }
    public void setPassword(String password)      { this.password = password; }
    public String getMobile()                     { return mobile; }
    public void setMobile(String mobile)          { this.mobile = mobile; }
    public String getAadhaarNumber()              { return aadhaarNumber; }
    public void setAadhaarNumber(String a)        { this.aadhaarNumber = a; }
    public String getRelationWithShaheed()        { return relationWithShaheed; }
    public void setRelationWithShaheed(String r)  { this.relationWithShaheed = r; }
    public String getMaritalStatus()              { return maritalStatus; }
    public void setMaritalStatus(String m)        { this.maritalStatus = m; }
    public String getOccupation()                 { return occupation; }
    public void setOccupation(String o)           { this.occupation = o; }
    public String getAddressLine()                { return addressLine; }
    public void setAddressLine(String a)          { this.addressLine = a; }
    public String getCity()                       { return city; }
    public void setCity(String city)              { this.city = city; }
    public String getState()                      { return state; }
    public void setState(String state)            { this.state = state; }
    public String getPincode()                    { return pincode; }
    public void setPincode(String pincode)        { this.pincode = pincode; }
    public String getStatus()                     { return status; }
    public void setStatus(String status)          { this.status = status; }
    public Timestamp getRegisteredDate()          { return registeredDate; }
    public void setRegisteredDate(Timestamp t)    { this.registeredDate = t; }

    public List<Shaheed> getShaheeds()                             { return shaheeds; }
    public void setShaheeds(List<Shaheed> shaheeds)                { this.shaheeds = shaheeds; }
    public List<Application> getApplications()                     { return applications; }
    public void setApplications(List<Application> applications)    { this.applications = applications; }
    public List<Document> getDocuments()                           { return documents; }
    public void setDocuments(List<Document> documents)             { this.documents = documents; }
    public List<FacilityAllocation> getFacilityAllocations()       { return facilityAllocations; }
    public void setFacilityAllocations(List<FacilityAllocation> l) { this.facilityAllocations = l; }
    public List<Feedback> getFeedbacks()                           { return feedbacks; }
    public void setFeedbacks(List<Feedback> feedbacks)             { this.feedbacks = feedbacks; }
}