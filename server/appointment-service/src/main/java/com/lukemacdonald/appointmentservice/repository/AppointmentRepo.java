package com.lukemacdonald.appointmentservice.repository;

import com.lukemacdonald.appointmentservice.model.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;

@Repository
public interface AppointmentRepo extends JpaRepository<Appointment, Long> {
    Appointment findById(int id);
    Appointment findAppointmentByDoctorAndDateAndTime(int doctor, Date date, String time);
    List<Appointment> findAppointmentByPatient(int patient);

    List<Appointment> findAllByDoctorAndDate(int doctor, Date date);
    List<Appointment> findAppointmentByDoctor(int doctor);
    List<Appointment> findAppointmentByDate(Date date);
    Appointment findAppointmentById(int id);
}
