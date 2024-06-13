package com.BigBangCoders_IICQuest.services;

import java.util.List;

import com.BigBangCoders_IICQuest.entities.Feedback;

public interface FeedbackService {
	 Feedback createFeedback(Feedback feedback);
	    List<Feedback> getAllFeedbacks();
}
