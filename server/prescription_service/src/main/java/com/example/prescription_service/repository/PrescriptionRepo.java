package com.example.prescription_service.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.prescription_service.model.Prescription;

public interface PrescriptionRepo extends JpaRepository<Prescription, Long> {
    Prescription findByPrescriptionID(int Id);
    List<Prescription> findAllByPatientID(int PatientId);
    List<Prescription> findAll();
}
