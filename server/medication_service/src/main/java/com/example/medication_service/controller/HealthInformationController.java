package com.example.medication_service.controller;

import com.example.medication_service.repository.HealthInformationRepo;
import com.example.medication_service.model.HealthInformation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



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
