package com.example.booking_service.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.example.booking_service.model.Appointment;
import com.example.booking_service.repository.AppointmentRepo;
import com.example.booking_service.repository.UserRepo;

import lombok.RequiredArgsConstructor;

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

    // Search for all appointments based off the patient's id
    @GetMapping(value="/search/userappointments/{id}")
    public List<Appointment> getAllAppointments(@PathVariable("id") int id){
        return appointRepo.findAppointmentByPatient(id);
    }

    // Remove an Appointment by it's ID
    @DeleteMapping(value = "/delete/appointment/{id}")
    public void deleteAppointment(@PathVariable("id") int id){
        Appointment targetAppointment = appointRepo.findAppointmentById(id);
        appointRepo.delete(targetAppointment);
    }

    // // Get list of appointments by the current date
    // @GetMapping(value="/search/appointment/date")
    // public List<Appointment> getUpcomingAppointments() {

    //     // Parse date to just dd/mm/YYYY
    //     Date in = new Date();
    //     LocalDateTime ldt = LocalDateTime.ofInstant(in.toInstant(), ZoneId.systemDefault());
    //     Date out = Date.from(ldt.atZone(ZoneId.systemDefault()).toInstant());
        
    //     List<Appointment> upcomingAppointments = appointRepo.findAppointmentByDate(out);

    //     for (int i = 0; i < upcomingAppointments.size(); i++) {
    //         System.out.println(upcomingAppointments.get(i));
    //     }

    //     return upcomingAppointments;
    // }

    // // On every day at midnight perform this task:
    // // Get appointments by the current date
    // // For all appointments at the current date, send an email to the patient
    // @GetMapping(value="/search/user/{id}")
    // public UserProjection notifyPatientBooking(@PathVariable int id) {

    //     List<Appointment> upcomingAppointments = getUpcomingAppointments();

    //     return userRepo.findUserById(id);
    // }
}
