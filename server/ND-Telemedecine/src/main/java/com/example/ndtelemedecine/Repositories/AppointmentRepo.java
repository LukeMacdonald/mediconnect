package com.example.ndtelemedecine.Repositories;

import com.example.ndtelemedecine.Models.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface AppointmentRepo extends JpaRepository<Appointment, Long>{
    Appointment findAppointmentByDoctorAndDateAndTime(int doctor,Date date,String time);
    List<Appointment> findByPatient(int id);
    Appointment findById(int id);
}
