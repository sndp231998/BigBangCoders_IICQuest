package com.BigBangCoders_IICQuest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.BigBangCoders_IICQuest.entities.Feedback;
import com.BigBangCoders_IICQuest.services.FeedbackService;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api")
public class FeedbackController {
	 @Autowired
	    private FeedbackService feedbackService;

	 @PostMapping("/feedback")
	   
	    public ResponseEntity<Feedback> createFeedback(@RequestBody Feedback feedback) {
	        Feedback savedFeedback = feedbackService.createFeedback(feedback);
	        return ResponseEntity.ok(savedFeedback);
	    }

	    @GetMapping("/")
	    public ResponseEntity<List<Feedback>> getAllFeedbacks() {
	        List<Feedback> feedbacks = feedbackService.getAllFeedbacks();
	        return ResponseEntity.ok(feedbacks);
	    }
}
