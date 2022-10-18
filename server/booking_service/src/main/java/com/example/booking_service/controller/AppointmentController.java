package com.example.booking_service.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.example.booking_service.model.Appointment;
import com.example.booking_service.repository.AppointmentRepo;
import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequiredArgsConstructor
public class AppointmentController {

    private final AppointmentRepo appointRepo;

    // Search for appointment based off the doctors ID, the date of the appointment and time, determine if it's valid or not
    @GetMapping(value="/search/appointment/{id}/{date}/{start_time}")
    public Boolean validateAppointment(@PathVariable("id") int id, @PathVariable("date") Date date, @PathVariable("start_time") String time){
        Appointment validAppoint = appointRepo.findAppointmentByDoctorAndDateAndTime(id, date, time);
        return validAppoint != null;
    }
    // Save appointment
    @PostMapping(value="/set/appointment")
    public ResponseEntity<?> saveAppointment(@RequestBody Appointment appoint){
        appointRepo.save(appoint);
        return ResponseEntity.ok().body(appoint.getId());
    }

    // Search and return for docotors that the patients are booked with based on id.
    @GetMapping(value="/search/appointment_doctors/{patientID}")
    public List<Integer> BookedDoctorsList(@PathVariable("patientID") int patientID){
        List<Appointment> booked_appointments = appointRepo.findAppointmentByPatient(patientID);

        List<Integer> unique_doctors = new ArrayList<>();

        for (Appointment appointment : booked_appointments) {
            if (!unique_doctors.contains(appointment.getDoctor())) {
                unique_doctors.add(appointment.getDoctor());
            }
        }

        return unique_doctors;
    }
    @GetMapping(value="/search/appointment_patients/{doctorID}")
    public List<Integer> BookedPatientsList(@PathVariable("doctorID") int doctorID){
        List<Appointment> booked_appointments = appointRepo.findAppointmentByDoctor(doctorID);
        List<Integer> unique_patients = new ArrayList<>();
        for (Appointment appointment : booked_appointments) {
            if (!unique_patients.contains(appointment.getPatient())) {
                unique_patients.add(appointment.getPatient());
            }
        }
        return unique_patients;
    }

    // Search for all appointments based off the patient's id
    @GetMapping(value="/search/patient/appointments/{id}")
    public ResponseEntity<?> getAllPatientAppointments(@PathVariable("id") int id){
        List<Appointment> upcoming = appointRepo.findAppointmentByPatient(id);
        if(upcoming.isEmpty()){
            return ResponseEntity.badRequest().body("No Upcoming Appointments");
        }
        else{
            return ResponseEntity.ok().body(upcoming);
        }
    }
    @GetMapping(value="/search/doctor/appointments/{id}")
    public ResponseEntity<?> getAllDoctorAppointments(@PathVariable("id") int id){
        List<Appointment> upcoming = appointRepo.findAppointmentByDoctor(id);
        if(upcoming.isEmpty()){
            return ResponseEntity.badRequest().body("No Upcoming Appointments");
        }
        else{
            return ResponseEntity.ok().body(upcoming);
        }
    }

    // Remove an Appointment by it's ID
    @DeleteMapping(value = "/delete/appointment/{id}")
    public void deleteAppointment(@PathVariable("id") int id){
        Appointment targetAppointment = appointRepo.findAppointmentById(id);
        appointRepo.delete(targetAppointment);
    }

    // Update appointment
    @PutMapping(value="/update/appointment")
    public ResponseEntity<?> updateAppointment(@RequestBody Appointment appointment) {

        Appointment availabilityToUpdate = appointRepo.findById(appointment.getId());

        if (availabilityToUpdate == null) {
            return ResponseEntity.badRequest().body("Appointment does not exist.");
        }

        appointRepo.save(availabilityToUpdate);
        return ResponseEntity.ok().body("Appointment Updated!");
    }

    @DeleteMapping(value = "/delete/patient/{patientID}")
    public void deleteAppointmentByPatient(@PathVariable("patientID") int id){
        List<Appointment> appointments = appointRepo.findAppointmentByPatient(id);
        appointRepo.deleteAll(appointments);
    }
    @DeleteMapping(value = "/delete/doctor/{doctorID}")
    public void deleteAppointmentByDoctor(@PathVariable("doctorID") int id){
        List<Appointment> appointments = appointRepo.findAppointmentByDoctor(id);
        appointRepo.deleteAll(appointments);
    }
}
