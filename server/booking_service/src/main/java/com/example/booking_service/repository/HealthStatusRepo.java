package com.example.booking_service.repository;

import com.example.booking_service.model.HealthStatus;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.*;

public interface HealthStatusRepo extends JpaRepository<HealthStatus, Long>{

    HealthStatus findHealthStatusById(int id);
 
}
