package com.BigBangCoders_IICQuest.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.BigBangCoders_IICQuest.entities.Blog;


public interface BlogRepo extends JpaRepository<Blog, Integer> {
	
	
	
}