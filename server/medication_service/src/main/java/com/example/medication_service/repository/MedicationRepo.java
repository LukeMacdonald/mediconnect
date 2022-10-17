package com.example.medication_service.repository;
import com.example.medication_service.model.Medication;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MedicationRepo extends JpaRepository<Medication, Long> {
    Medication findById(int id);
    List<Medication> findAllByUserId(int id);
}
