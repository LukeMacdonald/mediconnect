package com.lukemacdonald.medicalservice.repository;

import com.lukemacdonald.medicalservice.model.MedicalHistory;
import com.lukemacdonald.medicalservice.model.Medication;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MedicationRepo extends CrudRepository<Medication, Long> {
    Medication findById(int id);
    List<Medication> findAllByUserId(int id);
}
