//package com.BigBangCoders_IICQuest.services.impl;
//
//import org.modelmapper.ModelMapper;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.BigBangCoders_IICQuest.Payloads.AppoDto;
//import com.BigBangCoders_IICQuest.entities.Appo;
//import com.BigBangCoders_IICQuest.entities.Role;
//import com.BigBangCoders_IICQuest.entities.User;
//import com.BigBangCoders_IICQuest.exception.ResourceNotFoundException;
//import com.BigBangCoders_IICQuest.repositories.AppoRepo;
//import com.BigBangCoders_IICQuest.repositories.RoleRepo;
//import com.BigBangCoders_IICQuest.repositories.UserRepo;
//import com.BigBangCoders_IICQuest.services.AppoService;
//
//@Service
//public class AppoServiceImpl implements AppoService {
//
//    @Autowired
//    private ModelMapper modelMapper;
//
//    @Autowired
//    private AppoRepo appoRepo;
//
//    @Autowired
//    private UserRepo userRepo;
//
//    @Autowired
//    private RoleRepo roleRepo;
//
//    @Override
//    public AppoDto createAppointment(AppoDto appoDto, Integer userId) {
//        User user = this.userRepo.findById(userId)
//            .orElseThrow(() -> new ResourceNotFoundException("User", "User id", userId));

//        // Check if the user has the role of a normal user
//        boolean isNormalUser = user.getRoles().stream()
//            .anyMatch(role -> role.getRoleId() == 502);
//        if (!isNormalUser) {
//            throw new RuntimeException("Only normal users can create appointments");
//        }

//        // Set the role of the appointment to counselor
//        Role counselorRole = this.roleRepo.findById(503)
//            .orElseThrow(() -> new ResourceNotFoundException("Role", "Role id", 503));
//
//        Appo appo = this.modelMapper.map(appoDto, Appo.class);
//        appo.setUser(user);
//        appo.setRole(counselorRole);
//
//        Appo newApp = this.appoRepo.save(appo);
//        return this.modelMapper.map(newApp, AppoDto.class);
//    }
//}
