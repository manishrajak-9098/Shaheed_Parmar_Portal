package com.shaheed.service;
import com.shaheed.dao.FamilyDao;
import com.shaheed.entity.FamilyUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service @Transactional
public class FamilyService {
    @Autowired private FamilyDao familyDao;
    public void register(FamilyUser user) { familyDao.save(user); }
    public FamilyUser login(String email, String password) { return familyDao.login(email, password); }
    public FamilyUser findById(Long id) { return familyDao.findById(id); }
    public List<FamilyUser> getAll() { return familyDao.getAll(); }
    public void update(FamilyUser user) { familyDao.save(user); }
}