package com.lukemacdonald.medicalservice.repository;

import com.lukemacdonald.medicalservice.model.MedicalHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface  MedicalHistoryRepo extends CrudRepository<MedicalHistory, Long> {
    MedicalHistory findById(int id);
}
