package com.example.ndtelemedecine.DoctorAvailability;


import org.springframework.data.jpa.repository.JpaRepository;

public interface AvailabilityRepo extends JpaRepository<Availability, Long>  {
    
    
}
