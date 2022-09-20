package com.example.ndtelemedecine.Repositories;


import com.example.ndtelemedecine.Models.Availability;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface AvailabilityRepo extends JpaRepository<Availability, Long>  {

    List<Availability>      findByDoctorId(int id);

}
