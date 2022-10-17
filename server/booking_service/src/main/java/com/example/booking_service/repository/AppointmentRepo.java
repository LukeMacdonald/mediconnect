package com.example.booking_service.repository;

import com.example.booking_service.model.Appointment;

import org.springframework.data.jpa.repository.JpaRepository;

import java.sql.Date;

import java.util.*;

public interface AppointmentRepo extends JpaRepository<Appointment, Long>{
    Appointment findById(int id);
    Appointment findAppointmentByDoctorAndDateAndTime(int doctor, Date date, String time);
    List<Appointment> findAppointmentByPatient(int patient);
    List<Appointment> findAppointmentByDoctor(int doctor);
    List<Appointment> findAppointmentByDate(Date date);
    Appointment findAppointmentById(int id);
}
