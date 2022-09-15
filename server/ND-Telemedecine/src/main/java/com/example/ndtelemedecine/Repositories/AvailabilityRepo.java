package com.example.ndtelemedecine.DoctorAvailability;


import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface AvailabilityRepo extends JpaRepository<Availability, Long>  {

    List<Availability>      findByDoctorId(int id);
    List<Availability>      findBydayOfWeek(int day);
    List<Availability>      findBydoctorIdAndDayOfWeek(int id,int day);

}
