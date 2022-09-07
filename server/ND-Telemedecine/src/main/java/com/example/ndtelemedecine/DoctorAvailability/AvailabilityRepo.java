package com.example.ndtelemedecine.DoctorAvailability;


import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface AvailabilityRepo extends JpaRepository<Availability, Long>  {

    List<Availability>      findByDoctorId(long id);
    List<Availability>      findByDayOfWeek(int day);
    List<Availability>      findByDoctorIdAndDayOfWeek(long id,int day);
    
    
}
