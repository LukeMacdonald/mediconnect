package com.example.medication_service.controller;

import com.example.medication_service.repository.DisabilityRepo;
import com.example.medication_service.repository.HealthInformationRepo;
import com.example.medication_service.repository.IllnessRepo;
import com.example.medication_service.repository.MedicationRepo;
import com.example.medication_service.model.HealthInformation;
import com.example.medication_service.model.Disability;
import com.example.medication_service.model.Illness;
import com.example.medication_service.model.Medication;
import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



@RestController
@RequiredArgsConstructor
public class MedicationController {

    final private HealthInformationRepo healthInformationRepo;
    final private DisabilityRepo disabilityRepo;
    final private IllnessRepo illnessRepo;
    final private MedicationRepo medicationRepo;


    @PostMapping(value = "/set/healthinformation") 
    public ResponseEntity<HealthInformation> setHealthInformation(@RequestBody HealthInformation healthInformation) {
        healthInformationRepo.save(healthInformation);

        return ResponseEntity.ok().body(healthInformation);
    }

    @PostMapping(value = "/set/disability") 
    public ResponseEntity<Disability> setDisability(@RequestBody Disability disability) {
        disabilityRepo.save(disability);

        return ResponseEntity.ok().body(disability);
    }

    @PostMapping(value = "/set/illness") 
    public ResponseEntity<Illness> setIllness(@RequestBody Illness illness) {
        illnessRepo.save(illness);

        return ResponseEntity.ok().body(illness);
    }

    @PostMapping(value = "/set/medication") 
    public ResponseEntity<Medication> setMedication(@RequestBody Medication medication) {
        medicationRepo.save(medication);

        return ResponseEntity.ok().body(medication);
    }

    @GetMapping(value = "/get/healthinformation/{userId}")
    public ResponseEntity<HealthInformation> getHealthInformation(@PathVariable("userId") int userId){

        return ResponseEntity.ok().body(healthInformationRepo.findById(userId));
    }

    @GetMapping(value = "/get/disabilities/{userId}")
    public ResponseEntity<List<Disability>> getDisabilities(@PathVariable("userId") int userId){

        return ResponseEntity.ok().body(disabilityRepo.findAllByUserId(userId));
    }

    @GetMapping(value = "/get/illnesses/{userId}")
    public ResponseEntity<List<Illness>> getIllnesses(@PathVariable("userId") int userId){

        return ResponseEntity.ok().body(illnessRepo.findAllByUserId(userId));
    }

    @GetMapping(value = "/get/medications/{userId}")
    public ResponseEntity<List<Medication>> getMedication(@PathVariable("userId") int userId){

        return ResponseEntity.ok().body(medicationRepo.findAllByUserId(userId));
    }

    @DeleteMapping(value="/delete/healthinformation")
    public ResponseEntity<?> removeHealthInformation(@RequestBody HealthInformation healthInformation) {
        HealthInformation healthInformationRepoToRemove = healthInformationRepo.findById(healthInformation.getId());

        healthInformationRepo.delete(healthInformationRepoToRemove);
        return new ResponseEntity<>("Health Information removed successfully.", HttpStatus.OK);
    }

    @DeleteMapping(value="/delete/disability")
    public ResponseEntity<?> removeDisability(@RequestBody Disability disability) {
        Disability disabilityToRemove = disabilityRepo.findById(disability.getId());

        disabilityRepo.delete(disabilityToRemove);
        return new ResponseEntity<>("Disability removed successfully.", HttpStatus.OK);
    }
    
    @DeleteMapping(value="/delete/illness")
    public ResponseEntity<?> removeIllness(@RequestBody Illness illness) {
        Illness illnessToRemove = illnessRepo.findById(illness.getId());

        illnessRepo.delete(illnessToRemove);
        return new ResponseEntity<>("Illness removed successfully.", HttpStatus.OK);
    }

    @DeleteMapping(value="/delete/medication")
    public ResponseEntity<?> removeMedication(@RequestBody Medication medication) {
        Medication medicationToRemove = medicationRepo.findById(medication.getId());

        medicationRepo.delete(medicationToRemove);
        return new ResponseEntity<>("Medication removed successfully.", HttpStatus.OK);
    }

}
