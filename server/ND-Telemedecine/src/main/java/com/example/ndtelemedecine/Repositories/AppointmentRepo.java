package com.example.ndtelemedecine.Repositories;

import com.example.ndtelemedecine.Models.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.*;

public interface AppointmentRepo extends JpaRepository<Appointment, Long>{
    Appointment findAppointmentByDoctorAndDateAndTime(int doctor,Date date,String time);
    List<Appointment> findByPatient(int id);
    Appointment findById(int id);

    // @Modifying
    // @Query("UPDATE appointment SET appointment.doctor = :doctorId, appointment.date = :date, appointment.time = :time, appointment.today = :currTime where appointment.id = :appointId")
    // void updateAppointment(@Param(value="id") int id, @Param(value="doctor") int doctor,  @Param(value="time") String time, @Param(value="today") String today);
}
