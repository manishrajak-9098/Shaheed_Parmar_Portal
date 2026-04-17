package com.shaheed.dao;

import com.shaheed.entity.FamilyUser;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FamilyDao {

    @Autowired
    private SessionFactory sf;

    public void save(FamilyUser user) {
        sf.getCurrentSession().merge(user);
    }

    public FamilyUser findById(Long id) {
        return sf.getCurrentSession().get(FamilyUser.class, id);
    }

    public FamilyUser login(String email, String password) {
        return sf.getCurrentSession()
                 .createQuery("FROM FamilyUser WHERE email=:e AND password=:p", FamilyUser.class)
                 .setParameter("e", email)
                 .setParameter("p", password)
                 .uniqueResult();
    }

    public FamilyUser findByEmail(String email) {
        return sf.getCurrentSession()
                 .createQuery("FROM FamilyUser WHERE email=:e", FamilyUser.class)
                 .setParameter("e", email)
                 .uniqueResult();
    }

    public List<FamilyUser> getAll() {
        return sf.getCurrentSession()
                 .createQuery("FROM FamilyUser ORDER BY registeredDate DESC", FamilyUser.class)
                 .list();
    }
}