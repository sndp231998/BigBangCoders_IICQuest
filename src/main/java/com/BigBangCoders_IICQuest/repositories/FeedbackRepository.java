package com.BigBangCoders_IICQuest.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.BigBangCoders_IICQuest.entities.Feedback;

public interface FeedbackRepository extends JpaRepository<Feedback, Long> {
	
}