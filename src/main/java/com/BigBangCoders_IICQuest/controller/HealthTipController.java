package com.BigBangCoders_IICQuest.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.BigBangCoders_IICQuest.entities.HealthTip;
import com.BigBangCoders_IICQuest.services.HealthTipsService;
import com.BigBangCoders_IICQuest.services.NotificationService;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/health-tips")
public class HealthTipController {
	@Autowired
    private HealthTipsService healthTipService;
	
	 @GetMapping
	    public List<HealthTip> getAllHealthTips() {
	        return healthTipService.getAllHealthTips();
	    }
}