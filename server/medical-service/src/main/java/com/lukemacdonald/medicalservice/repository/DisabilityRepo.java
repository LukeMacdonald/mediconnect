package com.lukemacdonald.medicalservice.repository;

import com.lukemacdonald.medicalservice.model.Disability;
import com.lukemacdonald.medicalservice.model.MedicalHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DisabilityRepo extends CrudRepository<Disability, Long> {
    Disability findById(int id);
    List<Disability> findAllByUserId(int id);
}