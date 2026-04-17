package com.shaheed.dao;

import com.shaheed.entity.Feedback;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FeedbackDao {

    @Autowired
    private SessionFactory sf;

    public void save(Feedback fb) {
        sf.getCurrentSession().persist(fb);
    }

    public List<Feedback> findAll() {
        return sf.getCurrentSession()
                 .createQuery("FROM Feedback ORDER BY id DESC", Feedback.class)
                 .getResultList();
    }
}