package com.example.booking_service.repository;

import com.example.booking_service.model.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface AppointmentRepo extends JpaRepository<Appointment, Long>{

    Appointment findAppointmentByDoctorAndDateAndTime(int doctor, Date date, String time);
    List<Appointment> findAppointmentByPatient(int patient);
    List<Appointment> findAppointmentByDoctor(int patient);

}
