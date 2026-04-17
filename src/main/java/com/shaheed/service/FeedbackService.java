package com.shaheed.service;

import com.shaheed.dao.FeedbackDao;
import com.shaheed.entity.Feedback;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class FeedbackService {

    @Autowired
    private FeedbackDao feedbackDao;

    public void save(Feedback fb) {
        feedbackDao.save(fb);
    }

    public List<Feedback> getAll() {
        return feedbackDao.findAll();
    }
}