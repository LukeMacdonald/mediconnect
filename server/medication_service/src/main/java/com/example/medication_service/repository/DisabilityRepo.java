package com.example.medication_service.repository;
import com.example.medication_service.model.Disability;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DisabilityRepo extends JpaRepository<Disability, Long> {
    Disability findById(int id);
    List<Disability> findAllByUserId(int id);
}
