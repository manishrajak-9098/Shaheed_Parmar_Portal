package com.shaheed.entity;

import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "feedback")
public class Feedback {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "subject")
    private String subject;

    @Column(name = "message", columnDefinition = "TEXT")
    private String message;

    @Column(name = "submitted_date", insertable = false, updatable = false)
    private Timestamp submittedDate;

    // ── Associations ──
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_user_id", insertable = false, updatable = false)
    private FamilyUser familyUserRef;

    // ── Getters & Setters ──
    public Long getId()                          { return id; }
    public void setId(Long id)                   { this.id = id; }
    public String getName()                      { return name; }
    public void setName(String name)             { this.name = name; }
    public String getEmail()                     { return email; }
    public void setEmail(String email)           { this.email = email; }
    public String getSubject()                   { return subject; }
    public void setSubject(String subject)       { this.subject = subject; }
    public String getMessage()                   { return message; }
    public void setMessage(String message)       { this.message = message; }
    public Timestamp getSubmittedDate()          { return submittedDate; }
    public void setSubmittedDate(Timestamp t)    { this.submittedDate = t; }

    public FamilyUser getFamilyUserRef()                   { return familyUserRef; }
    public void setFamilyUserRef(FamilyUser familyUserRef) { this.familyUserRef = familyUserRef; }
}