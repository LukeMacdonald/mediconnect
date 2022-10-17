package com.example.medication_service.repository;
import com.example.medication_service.model.HealthInformation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HealthInformationRepo extends JpaRepository<HealthInformation, Long> {
    HealthInformation findById(int id);
}
