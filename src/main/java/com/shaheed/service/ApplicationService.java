package com.shaheed.service;
import com.shaheed.dao.ApplicationDao;
import com.shaheed.entity.Application;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service @Transactional
public class ApplicationService {
    @Autowired private ApplicationDao applicationDao;
    public Application save(Application app) { return applicationDao.save(app); }
    public Application findByFamilyUserId(Long fid) { return applicationDao.findByFamilyUserId(fid); }
    public Application findById(Long id) { return applicationDao.findById(id); }
    public List<Application> getAll() { return applicationDao.getAll(); }
    public List<Application> getByStatus(String status) { return applicationDao.getByStatus(status); }
    public long countByStatus(String status) { return applicationDao.countByStatus(status); }
    public long countAll() { return applicationDao.countAll(); }
    public void verify(Long appId, String status, String remarks, Long adminId) {
        applicationDao.verify(appId, status, remarks, adminId);
    }
}