package com.shaheed.service;
import com.shaheed.dao.DocumentDao;
import com.shaheed.entity.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service @Transactional
public class DocumentServiceImpl implements DocumentService {
    @Autowired private DocumentDao documentDao;
    @Override public Document save(Document doc) { return documentDao.save(doc); }
    @Override public Document findByFamilyId(Long fid) { return documentDao.findByFamilyId(fid); }
}