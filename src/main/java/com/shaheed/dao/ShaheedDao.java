package com.shaheed.dao;

import com.shaheed.entity.Shaheed;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ShaheedDao {

    @Autowired
    private SessionFactory sf;

    public Shaheed save(Shaheed shaheed) {
        return (Shaheed) sf.getCurrentSession().merge(shaheed);
    }

    public Shaheed findById(Long id) {
        return sf.getCurrentSession().get(Shaheed.class, id);
    }

    public Shaheed findByFamilyUserId(Long familyUserId) {
        List<Shaheed> list = sf.getCurrentSession()
                .createQuery(
                    "FROM Shaheed WHERE familyUserId=:f ORDER BY addedDate DESC",
                    Shaheed.class)
                .setParameter("f", familyUserId)
                .setMaxResults(1)
                .list();
        return list.isEmpty() ? null : list.get(0);
    }

    public List<Shaheed> getAll() {
        return sf.getCurrentSession()
                .createQuery(
                    "FROM Shaheed ORDER BY addedDate DESC",
                    Shaheed.class)
                .list();
    }

    public List<Shaheed> getByRank(String rank) {
        if (rank == null || rank.trim().isEmpty()) return getAll();
        return sf.getCurrentSession()
                .createQuery(
                    "FROM Shaheed WHERE rank=:r ORDER BY name",
                    Shaheed.class)
                .setParameter("r", rank)
                .list();
    }

    public List<String> getDistinctRanks() {
        return sf.getCurrentSession()
                .createQuery(
                    "SELECT DISTINCT s.rank FROM Shaheed s " +
                    "WHERE s.rank IS NOT NULL ORDER BY s.rank",
                    String.class)
                .list();
    }
}