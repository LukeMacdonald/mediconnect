package com.lukemacdonald.medicalservice.service;

import com.lukemacdonald.medicalservice.model.Prescription;
import com.lukemacdonald.medicalservice.repository.PrescriptionRepo;
import jakarta.ws.rs.NotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Transactional
@Slf4j
@Service
public class PrescriptionServiceImpl implements PrescriptionService {

    private final PrescriptionRepo prescriptionRepo;
    @Override
    public Prescription save(Prescription prescription) {
        return prescriptionRepo.save(prescription);
    }

    @Override
    public Prescription update(Prescription prescription) {
        // Check if the prescription with the given ID exists
        if (prescriptionRepo.existsById(prescription.getId())) {
            // Perform the update by saving the modified prescription
            return prescriptionRepo.save(prescription);
        } else {
            // Handle the case where the prescription with the given ID is not found
            throw new NotFoundException("Prescription not found with ID: " + prescription.getId());
            // You can create a custom exception class like NotFoundException to handle this case
        }
    }

    @Override
    public List<Prescription> patientPrescriptions(int patientId) {
        List<Prescription> prescriptions = prescriptionRepo.findAllByPatientId(patientId);
        if (!prescriptions.isEmpty()){
            return prescriptions;
        } else {
            // Handle the case where the prescription with the given ID is not found
            throw new NotFoundException("Prescriptions not found for Patient with ID: " + patientId);
            // You can create a custom exception class like NotFoundException to handle this case
        }
    }

    @Override
    public List<Prescription> all() {
        List<Prescription> prescriptions = prescriptionRepo.findAll();
        if (!prescriptions.isEmpty()){
            return prescriptions;
        } else {
            // Handle the case where the prescription with the given ID is not found
            throw new NotFoundException("Currently No Prescriptions");
            // You can create a custom exception class like NotFoundException to handle this case
        }
    }

    @Override
    public void delete(Prescription prescription) {
        int prescriptionId = prescription.getId();

        // Check if the prescription with the given ID exists
        if (prescriptionRepo.existsById(prescriptionId)) {
            prescriptionRepo.delete(prescription);
        } else {
            throw new NotFoundException("Prescription not found with ID: " + prescriptionId);
        }
    }
}
