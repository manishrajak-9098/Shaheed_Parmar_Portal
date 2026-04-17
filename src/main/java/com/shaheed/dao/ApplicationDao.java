package com.shaheed.dao;

import com.shaheed.entity.Application;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository
public class ApplicationDao {

    @Autowired
    private SessionFactory sf;

    public Application save(Application app) {
        return (Application) sf.getCurrentSession().merge(app);
    }

    public Application findById(Long id) {
        return sf.getCurrentSession().get(Application.class, id);
    }

    public Application findByFamilyUserId(Long familyUserId) {
        var list = sf.getCurrentSession()
                     .createQuery("FROM Application WHERE familyUserId=:f ORDER BY submissionDate DESC", Application.class)
                     .setParameter("f", familyUserId)
                     .setMaxResults(1)
                     .list();
        return list.isEmpty() ? null : list.get(0);
    }

    public List<Application> getAll() {
        return sf.getCurrentSession()
                 .createQuery("FROM Application ORDER BY submissionDate DESC", Application.class)
                 .list();
    }

    public List<Application> getByStatus(String status) {
        return sf.getCurrentSession()
                 .createQuery("FROM Application WHERE verificationStatus=:s ORDER BY submissionDate DESC", Application.class)
                 .setParameter("s", status)
                 .list();
    }

    public long countByStatus(String status) {
        return sf.getCurrentSession()
                        .createQuery("SELECT COUNT(a) FROM Application a WHERE a.verificationStatus=:s", Long.class)
                        .setParameter("s", status)
                        .uniqueResult();
    }

    //  Long.class add kiya gaya hai deprecation hatane ke liye...(createQuery)
    public long countAll() {
        return sf.getCurrentSession()
                        .createQuery("SELECT COUNT(a) FROM Application a", Long.class)
                        .uniqueResult();
    }

    public void verify(Long appId, String status, String remarks, Long adminId) {
        Application app = findById(appId);
        if (app != null) {
            app.setVerificationStatus(status);
            app.setAdminRemarks(remarks);
            app.setVerifiedByAdmin(adminId);
            app.setVerifiedDate(new Timestamp(System.currentTimeMillis()));
            sf.getCurrentSession().merge(app);
        }
    }
}