package com.lukemacdonald.appointmentservice.service;

import com.lukemacdonald.appointmentservice.model.Appointment;
import com.lukemacdonald.appointmentservice.model.HealthStatus;
import com.lukemacdonald.appointmentservice.repository.AppointmentRepo;
import com.lukemacdonald.appointmentservice.repository.HealthStatusRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AppointmentServiceImpl implements AppointmentService {

    private final AppointmentRepo appointmentRepo;

    private final HealthStatusRepo healthStatusRepo;

    @Override
    public Appointment findByID(int id) {
        Appointment appointment = appointmentRepo.findById(id);
        if (appointment != null ){
            appointment.setDateString(convertDate(appointment.getDate()));
        }
        return appointment;
    }

    @Override
    public Appointment findExactAppointment(int id, Date date, String time) {
        Appointment appointment = appointmentRepo.findAppointmentByDoctorAndDateAndTime(id, date, time);
        if (appointment != null ){
            appointment.setDateString(convertDate(appointment.getDate()));
        }
        return appointment;
    }

    @Override
    public Appointment save(Appointment appointment) {
        return appointmentRepo.save(appointment);
    }

    @Override
    public List<Appointment> findPatientAppointments(int id) {
        List<Appointment> appointments = appointmentRepo.findAppointmentByPatient(id);

        for (Appointment appointment : appointments) {
            appointment.setDateString(convertDate(appointment.getDate()));
        }

        return appointments;
    }

    public String convertDate(java.util.Date date){
        return new SimpleDateFormat("dd/MM/yyyy").format((date));
    }

    @Override
    public List<Appointment> findDoctorAppointments(int id) {
        List<Appointment> appointments = appointmentRepo.findAppointmentByDoctor(id);

        // Format date for each appointment
        for (Appointment appointment : appointments) {
            appointment.setDateString(convertDate(appointment.getDate()));
        }

        return appointments;
    }

    @Override
    public List<Appointment> findByDoctorAndDay(int doctor, Date date) {
        List<Appointment> appointments = appointmentRepo.findAllByDoctorAndDate(doctor, date);
        for (Appointment appointment : appointments) {
            appointment.setDateString(convertDate(appointment.getDate()));
        }
        return appointments;
    }

    @Override
    public Appointment update(Appointment appointment) {
        return appointmentRepo.save(appointment);
    }

    @Override
    public void delete(int id) {
        Appointment appointment = appointmentRepo.findById(id);
        appointmentRepo.delete(appointment);
    }

    @Override
    public void deleteHealthStatus(int id) {
        HealthStatus healthStatus = getStatus(id);
        healthStatusRepo.delete(healthStatus);
    }

    @Override
    public void deleteDoctorAppointments(int id) {
        List<Appointment> appointments = findDoctorAppointments(id);
        appointmentRepo.deleteAll(appointments);
    }

    @Override
    public void deletePatientAppointments(int id) {
        List<Appointment> appointments = findPatientAppointments(id);
        appointmentRepo.deleteAll(appointments);
    }

    @Override
    public HealthStatus saveStatus(HealthStatus status){
        return healthStatusRepo.save(status);
    }

    @Override
    public HealthStatus getStatus(int id){
        return healthStatusRepo.findHealthStatusByAppointmentId(id);
    }

    @Override
    public HealthStatus updateStatus(HealthStatus status){
        return healthStatusRepo.save(status);
    }
}
