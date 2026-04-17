package com.shaheed.dao;
import com.shaheed.entity.Facility;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class FacilityDao {
    @Autowired private SessionFactory sf;

    public List<Facility> getAll() {
        return sf.getCurrentSession().createQuery("FROM Facility", Facility.class).list();
    }
    public Facility findById(Long id) {
        return sf.getCurrentSession().get(Facility.class, id);
    }
}