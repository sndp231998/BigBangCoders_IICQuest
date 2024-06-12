package com.BigBangCoders_IICQuest.services;

import java.util.List;

import com.BigBangCoders_IICQuest.Payloads.UserDto;


public interface UserService {
UserDto registerNewUser(UserDto user);
	
	
	UserDto createUser(UserDto user);

	UserDto updateUser(UserDto user, Integer userId);

	UserDto getUserById(Integer userId);

	List<UserDto> getAllUsers();

	void deleteUser(Integer userId);
}
