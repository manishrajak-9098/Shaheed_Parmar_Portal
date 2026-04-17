package com.shaheed.dao;

import com.shaheed.entity.Document;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DocumentDao {

    @Autowired
    private SessionFactory sf;

    public Document save(Document doc) {
        return (Document) sf.getCurrentSession().merge(doc);
    }

    public Document findByFamilyId(Long familyId) {
        var list = sf.getCurrentSession()
                     .createQuery("FROM Document WHERE familyId=:f ORDER BY uploadDate DESC", Document.class)
                     .setParameter("f", familyId)
                     .setMaxResults(1)
                     .list();
        return list.isEmpty() ? null : list.get(0);
    }
}