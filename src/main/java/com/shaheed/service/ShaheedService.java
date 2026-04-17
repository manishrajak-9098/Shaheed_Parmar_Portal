package com.shaheed.service;
import com.shaheed.dao.ShaheedDao;
import com.shaheed.entity.Shaheed;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service @Transactional
public class ShaheedService {
    @Autowired private ShaheedDao shaheedDao;
    public Shaheed save(Shaheed s) { return shaheedDao.save(s); }
    public Shaheed findByFamilyUserId(Long fid) { return shaheedDao.findByFamilyUserId(fid); }
    public List<Shaheed> getAll() { return shaheedDao.getAll(); }
    public List<Shaheed> getByRank(String rank) { return shaheedDao.getByRank(rank); }
    public List<String> getDistinctRanks() { return shaheedDao.getDistinctRanks(); }
    public Shaheed findById(Long id) { return shaheedDao.findById(id); }
}