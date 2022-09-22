package com.example.ndtelemedecine.Controllers;

import com.example.ndtelemedecine.Models.Appointment;
import com.example.ndtelemedecine.Repositories.AppointmentRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;

@RestController
@RequiredArgsConstructor
public class AppointmentApiController {

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
}
