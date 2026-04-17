package com.shaheed.dao;
import com.shaheed.entity.FacilityAllocation;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class FacilityAllocationDao {
    @Autowired private SessionFactory sf;

    public FacilityAllocation save(FacilityAllocation fa) {
        return (FacilityAllocation) sf.getCurrentSession().merge(fa);
    }
    public List<FacilityAllocation> getByFamilyUserId(Long familyUserId) {
        return sf.getCurrentSession()
            .createQuery("FROM FacilityAllocation WHERE familyUserId=:f ORDER BY allocatedDate DESC", FacilityAllocation.class)
            .setParameter("f", familyUserId).list();
    }
    public List<FacilityAllocation> getByApplicationId(Long appId) {
        return sf.getCurrentSession()
            .createQuery("FROM FacilityAllocation WHERE applicationId=:a", FacilityAllocation.class)
            .setParameter("a", appId).list();
    }
    public List<FacilityAllocation> getAll() {
        return sf.getCurrentSession()
            .createQuery("FROM FacilityAllocation ORDER BY allocatedDate DESC", FacilityAllocation.class).list();
    }
}