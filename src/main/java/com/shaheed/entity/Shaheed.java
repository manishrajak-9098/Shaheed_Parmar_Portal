package com.shaheed.entity;

import jakarta.persistence.*;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name = "shaheed")
public class Shaheed {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "`rank`")
    private String rank;

    @Column(name = "army_unit")
    private String armyUnit;

    @Column(name = "regiment")
    private String regiment;

    @Column(name = "service_number", nullable = false)
    private String serviceNumber;

    @Column(name = "date_of_birth")
    private String dateOfBirth;

    @Column(name = "martyrdom_date")
    private String martyrdomDate;

    @Column(name = "place_of_martyrdom")
    private String placeOfMartyrdom;

    @Column(name = "photo_path")
    private String photoPath;

    @Column(name = "family_user_id")
    private Long familyUserId;

    @Column(name = "added_date", insertable = false, updatable = false)
    private Timestamp addedDate;

    // ── Associations ──
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_user_id", insertable = false, updatable = false)
    private FamilyUser familyUserRef;

    @OneToMany(mappedBy = "shaheedRef", fetch = FetchType.LAZY)
    private List<Application> applications;

    @OneToMany(mappedBy = "shaheedRef", fetch = FetchType.LAZY)
    private List<Document> documents;

    // ── Getters & Setters ──
    public Long getId()                             { return id; }
    public void setId(Long id)                      { this.id = id; }
    public String getName()                         { return name; }
    public void setName(String name)                { this.name = name; }
    public String getRank()                         { return rank; }
    public void setRank(String rank)                { this.rank = rank; }
    public String getArmyUnit()                     { return armyUnit; }
    public void setArmyUnit(String armyUnit)        { this.armyUnit = armyUnit; }
    public String getRegiment()                     { return regiment; }
    public void setRegiment(String regiment)        { this.regiment = regiment; }
    public String getServiceNumber()                { return serviceNumber; }
    public void setServiceNumber(String s)          { this.serviceNumber = s; }
    public String getDateOfBirth()                  { return dateOfBirth; }
    public void setDateOfBirth(String d)            { this.dateOfBirth = d; }
    public String getMartyrdomDate()                { return martyrdomDate; }
    public void setMartyrdomDate(String d)          { this.martyrdomDate = d; }
    public String getPlaceOfMartyrdom()             { return placeOfMartyrdom; }
    public void setPlaceOfMartyrdom(String p)       { this.placeOfMartyrdom = p; }
    public String getPhotoPath()                    { return photoPath; }
    public void setPhotoPath(String p)              { this.photoPath = p; }
    public Long getFamilyUserId()                   { return familyUserId; }
    public void setFamilyUserId(Long f)             { this.familyUserId = f; }
    public Timestamp getAddedDate()                 { return addedDate; }
    public void setAddedDate(Timestamp t)           { this.addedDate = t; }

    public FamilyUser getFamilyUserRef()                   { return familyUserRef; }
    public void setFamilyUserRef(FamilyUser familyUserRef) { this.familyUserRef = familyUserRef; }
    public List<Application> getApplications()             { return applications; }
    public void setApplications(List<Application> list)    { this.applications = list; }
    public List<Document> getDocuments()                   { return documents; }
    public void setDocuments(List<Document> documents)     { this.documents = documents; }
}