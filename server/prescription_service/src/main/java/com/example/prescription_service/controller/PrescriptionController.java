package com.example.prescription_service.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.prescription_service.exception.EmptyListException;
import com.example.prescription_service.exception.PrescriptionNotExists;
import com.example.prescription_service.model.Prescription;
import com.example.prescription_service.repository.PrescriptionRepo;
import com.example.prescription_service.service.PrescriptionAlertService;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
public class PrescriptionController {
    
    @Autowired
    private PrescriptionRepo prescriptionRepo;

    @Autowired
    private PrescriptionAlertService prescriptionAlertService;

    @GetMapping(value = "/")
    public String Home() {
        return "Home page. Can delete later when necessary";
    }

    @PostMapping(value="/prescribe")
    public ResponseEntity<Prescription> prescribePatient(@RequestBody Prescription prescription) {
        prescriptionRepo.save(prescription);
        return new ResponseEntity<>(prescription, HttpStatus.OK);
    }

    @PutMapping(value="/prescribe")
    public ResponseEntity<Prescription> updatePatientPrescription(@RequestBody Prescription prescription) {
        Prescription prescriptionToUpdate = prescriptionRepo.findByPrescriptionID(prescription.getprescriptionID());

        if (prescriptionToUpdate == null) {
            throw new PrescriptionNotExists("Prescription does not exist.");
        }

        prescriptionToUpdate.setDoctorID(prescription.getDoctorID());
        prescriptionToUpdate.setPatientID(prescription.getPatientID());
        prescriptionToUpdate.setName(prescription.getName());
        prescriptionToUpdate.setDosage(prescription.getDosage());
        prescriptionToUpdate.setRepeats(prescription.getRepeats());

        prescriptionRepo.save(prescriptionToUpdate);
        return new ResponseEntity<>(prescription, HttpStatus.OK);
    }

    @GetMapping(value = "/search/prescriptions/{patientId}")
    public ResponseEntity<List<Prescription>> viewPatientPrescriptions(@PathVariable("patientId") int patientId) {
        
        if (prescriptionRepo.findAllByPatientID(patientId).size() == 0) {
            throw new EmptyListException("Could not find any prescriptions.");
        }

        return new ResponseEntity<>(prescriptionRepo.findAllByPatientID(patientId), HttpStatus.OK);
    }

    @GetMapping(value = "/search/prescriptions")
    public ResponseEntity<?> viewAllPrescriptions() {
        
        List<Prescription> prescriptionList = prescriptionAlertService.getAllPrescription();
        if (prescriptionList.size() <= 0) {
            throw new EmptyListException("There are currently no prescriptions.");
        }

        return new ResponseEntity<>(prescriptionRepo.findAll(), HttpStatus.OK);
    }

    @DeleteMapping(value="/delete/prescription")
    public ResponseEntity<?> removePrescription(@RequestBody Prescription prescription) {
        Prescription prescriptionToRemove = prescriptionRepo.findByPrescriptionID(prescription.getprescriptionID());

        if (prescriptionToRemove == null) {
            throw new PrescriptionNotExists("Prescription does not exist.");
        }
        prescriptionRepo.delete(prescriptionToRemove);
        return new ResponseEntity<>("Prescription removed successfully.", HttpStatus.OK);
    }

    // Manually call prescription alert service, alerting all users that they have prescriptions to take.
    @GetMapping(value="/alert/prescription")
    public String alertPrescriptions() {
        return prescriptionAlertService.remindPrescriptions();
    }
    
    @GetMapping(value="/alert/prescription/{prescriptionID}")
    public String alertSinglePrescription(@RequestParam("prescriptionID") int prescriptionID) {
        Prescription prescriptionToNotify = prescriptionRepo.findByPrescriptionID(prescriptionID);

        prescriptionAlertService.alertSinglePatient(prescriptionToNotify);
        return "Sent prescription alert message successfully.";
    }
}
