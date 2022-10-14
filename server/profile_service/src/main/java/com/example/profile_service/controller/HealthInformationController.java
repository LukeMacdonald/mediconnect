package com.example.profile_service.controller;

import com.example.profile_service.model.Verification;
import com.example.profile_service.repository.HealthInformationRepo;
import com.example.profile_service.repository.VerificationRepo;
import com.example.profile_service.service.MapValidationErrorService;
import com.example.profile_service.service.UserService;
import com.example.profile_service.validator.UserValidator;
import com.example.profile_service.model.Doctor;
import com.example.profile_service.model.HealthInformation;
import com.example.profile_service.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class HealthInformationController {

    final private HealthInformationRepo healthInformationRepo;

    @PostMapping(value = "/set/healthinformation") 
    public ResponseEntity<HealthInformation> setHealthInformation(@RequestBody HealthInformation healthInformation) {
        healthInformationRepo.save(healthInformation);

        return ResponseEntity.ok().body(healthInformation);
    }

    @GetMapping(value = "/get/healthinformation/{userId}")
    public ResponseEntity<HealthInformation> getHealthInformation(@PathVariable("userId") int userId){

        return ResponseEntity.ok().body(healthInformationRepo.findById(userId));
    }
    
}
