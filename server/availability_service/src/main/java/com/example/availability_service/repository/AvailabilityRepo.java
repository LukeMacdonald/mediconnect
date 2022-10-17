package com.example.availability_service.repository;

import com.example.availability_service.model.Availability;
import org.springframework.data.jpa.repository.JpaRepository;


import java.util.List;

public interface AvailabilityRepo extends JpaRepository<Availability, Long> {
    Availability       findById(int id);
    List<Availability> findByDoctorId(int id);
}
