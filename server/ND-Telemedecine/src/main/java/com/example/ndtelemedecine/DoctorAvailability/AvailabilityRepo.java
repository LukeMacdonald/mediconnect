package com.example.ndtelemedecine.DoctorAvailability;


import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface AvailabilityRepo extends JpaRepository<Availability, Long>  {

    List<Availability>      findBydoctorId(long id);
    List<Availability>      findBydayOfWeek(int day);
    List<Availability>      findBydoctorIdAndDayOfWeek(long id,int day);
    
}
