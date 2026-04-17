package com.shaheed.dao;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.shaheed.entity.Admin;

@Repository
public class AdminDao {
    @Autowired
    private SessionFactory sessionFactory;

    public Admin login(String username, String password){
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("from Admin where username=:u and password=:p", Admin.class)
            .setParameter("u", username)
            .setParameter("p", password)
            .uniqueResult();
    }
}