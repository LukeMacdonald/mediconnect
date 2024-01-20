package com.lukemacdonald.appointmentservice.controller;

import com.lukemacdonald.appointmentservice.model.Appointment;
import com.lukemacdonald.appointmentservice.model.HealthStatus;
import com.lukemacdonald.appointmentservice.service.AppointmentService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("appointment")
@RequiredArgsConstructor
public class AppointmentController {

    private final AppointmentService appointmentService;

    // Search for appointment based off the doctors ID, the date of the appointment and start_time, determine if it's valid or not
    @GetMapping(value="")
    public Boolean validateAppointment(@RequestParam int id, @RequestParam Date date, @RequestParam String start_time){
        Appointment validAppoint = appointmentService.findExactAppointment(id, date, start_time);
        return validAppoint != null;
    }
    // Save appointment
    @PostMapping(value="/save")
    public ResponseEntity<?> saveAppointment(@RequestBody Appointment appointment){
        appointmentService.save(appointment);
        return ResponseEntity.ok().body(appointment.getId());
    }

    // Search and return for docotors that the patients are booked with based on id.
    @GetMapping(value="/patient/find-doctors")
    public List<Integer> BookedDoctorsList(@RequestParam int id){
        List<Appointment> booked_appointments = appointmentService.findPatientAppointments(id);

        List<Integer> unique_doctors = new ArrayList<>();

        for (Appointment appointment : booked_appointments) {
            if (!unique_doctors.contains(appointment.getDoctor())) {
                unique_doctors.add(appointment.getDoctor());
            }
        }

        return unique_doctors;
    }
    @GetMapping(value="/doctor/find-patients")
    public List<Integer> BookedPatientsList(@RequestParam int id){
        List<Appointment> booked_appointments = appointmentService.findDoctorAppointments(id);
        List<Integer> unique_patients = new ArrayList<>();
        for (Appointment appointment : booked_appointments) {
            if (!unique_patients.contains(appointment.getPatient())) {
                unique_patients.add(appointment.getPatient());
            }
        }
        return unique_patients;
    }

    // Search for all appointments based off the patient's id
    @GetMapping(value="/patient")
    public ResponseEntity<?> getAllPatientAppointments(@RequestParam int id){
        List<Appointment> upcoming = appointmentService.findPatientAppointments(id);
        if(upcoming.isEmpty()){
            return ResponseEntity.badRequest().body("No Upcoming Appointments");
        }
        else{
            upcoming.forEach(appointment -> {System.out.println(appointment.getDate());});

            return ResponseEntity.ok().body(upcoming);
        }
    }
    @GetMapping(value="/doctor")
    public ResponseEntity<?> getAllDoctorAppointments(@RequestParam int id){
        List<Appointment> upcoming = appointmentService.findDoctorAppointments(id);
        if(upcoming.isEmpty()){
            return ResponseEntity.badRequest().body("No Upcoming Appointments");
        }
        else{
            return ResponseEntity.ok().body(upcoming);
        }
    }
    @GetMapping(value = "/check")
    public ResponseEntity<?> getAllDoctorAppointments(
            @RequestParam int id,
            @RequestParam String date) {

        try {
            // Parse the String date to java.util.Date
            SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");

            java.util.Date parsedDate = format.parse(date);

            // Convert java.util.Date to java.sql.Date
            Date sqlDate = new Date(parsedDate.getTime());

            // Now you can use sqlDate in your service method
            List<Appointment> appointments = appointmentService.findByDoctorAndDay(id, sqlDate);

            if (appointments.isEmpty()) {
                return ResponseEntity.status(204).body("No Upcoming Appointments");
            } else {
                return ResponseEntity.ok().body(appointments);
            }
        } catch (ParseException e) {
            // Handle the case where the date string is not in the expected format
            return ResponseEntity.status(400).body("Invalid date format. Use dd/MM/yyyy");
        }
    }

    // Remove an Appointment by it's ID
    @DeleteMapping(value = "/delete")
    public void deleteAppointment(@RequestParam int id){
        appointmentService.delete(id);
    }

    // Update appointment
    @PutMapping(value="/update")
    public ResponseEntity<?> updateAppointment(@RequestBody Appointment appointment) {
        Appointment updatedAppointment = appointmentService.update(appointment);

        if ( updatedAppointment == null) {
            return ResponseEntity.badRequest().body("Appointment does not exist.");
        }
        return ResponseEntity.ok().body("Appointment Updated!");
    }

    @DeleteMapping(value = "/patient/delete")
    public void deleteAppointmentByPatient(@RequestParam int id){
        appointmentService.deletePatientAppointments(id);
    }
    @DeleteMapping(value = "/doctor/delete")
    public void deleteAppointmentByDoctor(@RequestParam int id){
        appointmentService.deleteDoctorAppointments(id);
    }


    @GetMapping(value="/health-status")
    public ResponseEntity<?> getHealthStatus(@RequestParam int id){
        HealthStatus healthStatus = appointmentService.getStatus(id);

        if (healthStatus != null) {
            return ResponseEntity.ok().body(healthStatus);
        }

        return ResponseEntity.status(404).body("Status not found");
    }
    // Save Health Status
    @PostMapping(value="/health-status")
    public ResponseEntity<?> saveHealthStatus(@RequestBody HealthStatus healthstatus){

        HealthStatus saved = appointmentService.saveStatus(healthstatus);

        if (saved != null){
            return ResponseEntity.ok().body(saved);
        }
        return ResponseEntity.status(404).body("Status could not be saved");
    }

    // Save Health Status
    @PutMapping(value="/health-status")
    public ResponseEntity<?> updateHealthStatus(@RequestBody HealthStatus healthstatus){
        HealthStatus healthStatusToUpdate = appointmentService.getStatus(healthstatus.getAppointmentId());

        if (healthStatusToUpdate != null) {
            appointmentService.updateStatus(healthstatus);
            return ResponseEntity.ok().body(healthStatusToUpdate);
        }

        return ResponseEntity.status(404).body("Status not found");

    }

    @DeleteMapping(value="/health-status")
    public ResponseEntity<?> deleteHealthStatus(@RequestParam int id){

        appointmentService.deleteHealthStatus(id);

        return ResponseEntity.status(404).body("Status deleted");
    }
}
