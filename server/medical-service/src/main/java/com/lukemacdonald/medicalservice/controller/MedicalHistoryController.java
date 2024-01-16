package com.lukemacdonald.medicalservice.controller;

import com.lukemacdonald.medicalservice.model.*;
import com.lukemacdonald.medicalservice.service.MedicalHistoryService;
import com.lukemacdonald.medicalservice.service.PrescriptionService;
import jakarta.ws.rs.NotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("medical")
public class MedicalHistoryController {

    private final MedicalHistoryService medicalHistoryService;

    private final PrescriptionService prescriptionService;

    @PostMapping(value = "/save/history")
    public ResponseEntity<?> saveHistory(@RequestBody MedicalHistory history)


    {
        System.out.print(history.getId());
        medicalHistoryService.saveHistory(history);

        return ResponseEntity.ok().body("Medical History Saved");
    }

    @PostMapping(value = "/save/disability")
    public ResponseEntity<?> saveDisability(@RequestBody Disability disability)
    {
        Disability newDisability = medicalHistoryService.saveDisability(disability);
        return ResponseEntity.ok().body(newDisability);
    }

    @PostMapping(value = "/save/illness")
    public ResponseEntity<?> saveIllness(@RequestBody Illness illness)
    {
        Illness newIllness = medicalHistoryService.saveIllness(illness);
        return ResponseEntity.ok().body(newIllness);
    }

    @PostMapping(value = "/save/medication")
    public ResponseEntity<?> save(@RequestBody Medication medication)
    {
        Medication newMedication = medicalHistoryService.saveMedication(medication);
        return ResponseEntity.ok().body(newMedication);
    }

    @GetMapping("/get/{id}")
    public ResponseEntity<?> get(@PathVariable int id){

        return ResponseEntity.ok().body(medicalHistoryService.getAll(id));
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> delete(@PathVariable int id){

        medicalHistoryService.deleteAll(id);

        return ResponseEntity.ok().body("Medical History Deleted!");
    }


    @PostMapping(value="/prescription")
    public ResponseEntity<?> prescribePatient(@RequestBody Prescription prescription) {
        Prescription saved = prescriptionService.save(prescription);
        if (saved == null){
            return new ResponseEntity<>("Error saving prescription", HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(prescription, HttpStatus.OK);
    }

    @PutMapping(value="/prescription")
    public ResponseEntity<?> updatePatientPrescription(@RequestBody Prescription prescription) {
        try {
            Prescription updated = prescriptionService.update(prescription);
            return ResponseEntity.ok().body(updated);
        } catch (NotFoundException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping(value = "/prescriptions/{patientId}")
    public ResponseEntity<?> viewPatientPrescriptions(@PathVariable("patientId") int patientId) {
        try {
            List<Prescription> prescriptions = prescriptionService.patientPrescriptions(patientId);
            return ResponseEntity.ok().body(prescriptions);
        } catch (NotFoundException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping(value = "/prescriptions")
    public ResponseEntity<?> viewAllPrescriptions() {
        try {
            List<Prescription> prescriptions = prescriptionService.all();
            return ResponseEntity.ok().body(prescriptions);
        } catch (NotFoundException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping(value="/prescription")
    public ResponseEntity<?> removePrescription(@RequestBody Prescription prescription) {
        try {
            prescriptionService.delete(prescription);
            return ResponseEntity.ok().body("Prescription deleted");
        } catch (NotFoundException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }



}
