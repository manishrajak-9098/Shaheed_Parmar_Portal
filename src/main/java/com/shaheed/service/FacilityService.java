package com.shaheed.service;
import com.shaheed.dao.FacilityDao;
import com.shaheed.entity.Facility;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service @Transactional
public class FacilityService {
    @Autowired private FacilityDao facilityDao;
    public List<Facility> getAll() { return facilityDao.getAll(); }
    public Facility findById(Long id) { return facilityDao.findById(id); }
}