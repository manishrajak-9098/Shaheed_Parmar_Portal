package com.shaheed.service;
import com.shaheed.dao.AdminDao;
import com.shaheed.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service @Transactional
public class AdminService {
    @Autowired AdminDao adminDao;
    public Admin login(String username, String password) { return adminDao.login(username, password); }
}