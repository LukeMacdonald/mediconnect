package com.lukemacdonald.medicalservice.repository;

import com.lukemacdonald.medicalservice.model.Prescription;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PrescriptionRepo extends JpaRepository<Prescription, Long> {
    Prescription findById(int Id);

    boolean existsById(int id);
    List<Prescription> findAllByPatientId(int PatientId);

    List<Prescription> findAll();

}