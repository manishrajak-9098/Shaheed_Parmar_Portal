package com.shaheed.service;
import com.shaheed.dao.FacilityAllocationDao;
import com.shaheed.entity.FacilityAllocation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service @Transactional
public class FacilityAllocationService {
    @Autowired private FacilityAllocationDao dao;
    public FacilityAllocation save(FacilityAllocation fa) { return dao.save(fa); }
    public List<FacilityAllocation> getByFamilyUserId(Long fid) { return dao.getByFamilyUserId(fid); }
    public List<FacilityAllocation> getByApplicationId(Long aid) { return dao.getByApplicationId(aid); }
    public List<FacilityAllocation> getAll() { return dao.getAll(); }
}