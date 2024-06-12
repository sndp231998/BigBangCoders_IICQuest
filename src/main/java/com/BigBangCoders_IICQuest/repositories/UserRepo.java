package com.BigBangCoders_IICQuest.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.BigBangCoders_IICQuest.entities.User;


public interface UserRepo extends JpaRepository<User, Integer>{
	
	
Optional<User> findByEmail(String email);
}
