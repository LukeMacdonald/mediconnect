package com.example.prescription_service.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.prescription_service.model.Prescription;

public interface PrescriptionRepo extends JpaRepository<Prescription, Long> {
    Prescription findByPrescriptionId(int Id);
    Prescription findByPatientId(int PatientId);
    List<Prescription> findAll();
}
