//package com.BigBangCoders_IICQuest.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.CrossOrigin;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.BigBangCoders_IICQuest.Payloads.AppoDto;
//import com.BigBangCoders_IICQuest.services.AppoService;
//
//@CrossOrigin(origins = "*")
//@RestController
//@RequestMapping("/api/v1/")
//public class AppoController {
//
//    @Autowired
//    private AppoService appoService;
//
//    @PostMapping("/user/{userId}/appos")
//    public ResponseEntity<AppoDto> createAppointment(@RequestBody AppoDto appoDto, @PathVariable Integer userId) {
//        AppoDto createAppo = this.appoService.createAppointment(appoDto, userId);
//        return new ResponseEntity<AppoDto>(createAppo, HttpStatus.CREATED);
//    }
//}
