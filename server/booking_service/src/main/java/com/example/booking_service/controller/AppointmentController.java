package com.example.booking_service.controller;

import java.util.ArrayList;
import java.util.List;

import com.example.booking_service.model.Appointment;
import com.example.booking_service.repository.AppointmentRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import java.sql.Date;

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
    public String saveAppointment(@RequestBody Appointment appoint){
        appointRepo.save(appoint);
        return "Appointment successfully saved";
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
}
