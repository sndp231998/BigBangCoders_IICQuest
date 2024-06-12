package com.BigBangCoders_IICQuest.services.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.BigBangCoders_IICQuest.Payloads.ApiResponse;
import com.BigBangCoders_IICQuest.Payloads.LoginDto;
import com.BigBangCoders_IICQuest.Payloads.UserDto;
import com.BigBangCoders_IICQuest.entities.User;
import com.BigBangCoders_IICQuest.exception.ResourceNotFoundException;
import com.BigBangCoders_IICQuest.repositories.UserRepo;
import com.BigBangCoders_IICQuest.services.UserService;




@Service
public class UserServiceImpl implements UserService {

	
	
	@Autowired
	private UserRepo userRepo;

	@Autowired
	private ModelMapper modelMapper;
	


	@Override
	public UserDto createUser(UserDto userDto) {
		User user = this.dtoToUser(userDto);
		User savedUser = this.userRepo.save(user);
		return this.userToDto(savedUser);
	}

	@Override
	public UserDto updateUser(UserDto userDto, Integer userId) {

		User user = this.userRepo.findById(userId)
				.orElseThrow(() -> new ResourceNotFoundException("User", " Id ", userId));

		user.setName(userDto.getName());
		user.setEmail(userDto.getEmail());
		user.setPassword(userDto.getPassword());
		user.setAbout(userDto.getAbout());

		User updatedUser = this.userRepo.save(user);
		UserDto userDto1 = this.userToDto(updatedUser);
		return userDto1;
	}

	@Override
	public UserDto getUserById(Integer userId) {

		User user = this.userRepo.findById(userId)
				.orElseThrow(() -> new ResourceNotFoundException("User", " Id ", userId));

		return this.userToDto(user);
	}

	@Override
	public List<UserDto> getAllUsers() {

		List<User> users = this.userRepo.findAll();
		List<UserDto> userDtos = users.stream().map(user -> this.userToDto(user)).collect(Collectors.toList());

		return userDtos;
	}

	@Override
	public void deleteUser(Integer userId) {
		User user = this.userRepo.findById(userId)
				.orElseThrow(() -> new ResourceNotFoundException("User", "Id", userId));
		this.userRepo.delete(user);

	}

	public User dtoToUser(UserDto userDto) {
		User user = this.modelMapper.map(userDto, User.class);

		// user.setId(userDto.getId());
		// user.setName(userDto.getName());
		// user.setEmail(userDto.getEmail());
		// user.setAbout(userDto.getAbout());
		// user.setPassword(userDto.getPassword());
		return user;
	}

	public UserDto userToDto(User user) {
		UserDto userDto = this.modelMapper.map(user, UserDto.class);
		return userDto;
	}

	
	//Time ubryo vane Role  pn rakhne
	@Override
	public UserDto registerNewUser(UserDto userDto) {

		
		
		 User newUser = this.dtoToUser(userDto);
	        User savedUser = this.userRepo.save(newUser);
	        return this.userToDto(savedUser);

	}
	
	@Override
	public ApiResponse login(LoginDto loginDto) {
		 User user = userRepo.findByEmail(loginDto.getEmail());
		 System.out.print(user+"12");
	        if (user == null) {
	        	//System.out.print(user);
	            throw new RuntimeException((loginDto.getPassword()));
	            }else
	                if (user.getPassword().equals(loginDto.getPassword())) {
	                	  int userId = user.getUserId();
	                	  String name=user.getName();
	                	  
	                	  System.out.print(name+"jss");
	                	return new ApiResponse("Login Success ",true, name, userId);
	        }else
	        throw new RuntimeException("Password mismatch.");

	        }


}
