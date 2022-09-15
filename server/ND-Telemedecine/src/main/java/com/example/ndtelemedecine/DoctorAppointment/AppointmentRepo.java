package com.example.ndtelemedecine.DoctorAppointment;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface AppointmentRepo extends JpaRepository<Appointment, Long>{
    Appointment findAppointmentByDoctorAndDateAndTime(int doctor,Date date,String time);

}
