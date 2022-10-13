package com.example.prescription_service.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.prescription_service.model.Prescription;
import com.example.prescription_service.repository.PrescriptionRepo;

@RestController
public class PrescriptionController {
    @Autowired
    private PrescriptionRepo prescriptionRepo;

    @GetMapping(value = "/")
    public String Home() {
        return "Home page. Can delete later when necessary";
    }

    @PostMapping(value="/prescribe")
    public ResponseEntity<Prescription> prescribePatient(@RequestBody Prescription prescription) {
        // TODO: Error checks to implement here later
        prescriptionRepo.save(prescription);
        return new ResponseEntity<>(prescription, HttpStatus.OK);
    }
}
