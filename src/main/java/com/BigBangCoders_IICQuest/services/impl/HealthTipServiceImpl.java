package com.BigBangCoders_IICQuest.services.impl;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.BigBangCoders_IICQuest.entities.HealthTip;
import com.BigBangCoders_IICQuest.repositories.HealthTipRepo;
import com.BigBangCoders_IICQuest.services.HealthTipsService;

@Service
public class HealthTipServiceImpl   implements HealthTipsService {
    @Autowired
    private HealthTipRepo healthTipRepository;

    @Override
    public List<HealthTip> getAllHealthTips() {
        return healthTipRepository.findAll();
    }

    
}
