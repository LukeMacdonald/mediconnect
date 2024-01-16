package com.lukemacdonald.appointmentservice.service;

import com.lukemacdonald.appointmentservice.model.Appointment;
import com.lukemacdonald.appointmentservice.model.HealthStatus;

import java.sql.Date;
import java.util.List;

public interface AppointmentService {

    Appointment findByID(int id);

    Appointment findExactAppointment(int id, Date date, String time);

    Appointment save(Appointment appointment);

    List<Appointment> findPatientAppointments(int id);

    List<Appointment> findDoctorAppointments(int id);

    List<Appointment> findByDoctorAndDay(int doctor, Date date);

    HealthStatus saveStatus(HealthStatus status);

    HealthStatus getStatus(int id);

    HealthStatus updateStatus(HealthStatus status);


    Appointment update(Appointment appointment);

    void delete(int id);

    void deleteHealthStatus(int id);

    void deleteDoctorAppointments(int id);

    void deletePatientAppointments(int id);

















}
