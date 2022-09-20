package com.example.ndtelemedecine.Controllers;

import com.example.ndtelemedecine.Models.Appointment;
import com.example.ndtelemedecine.Repositories.AppointmentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;

@RestController
public class AppointmentApiController {
    @Autowired
    private AppointmentRepo appointRepo;

    // Search for appointment based off the doctors ID, the date of the appointment and time, determine if it's valid or not
    @GetMapping(value="/SearchAppointment/{id}/{date}/{start_time}")
    public Boolean validateAppointment(@PathVariable("id") int id, @PathVariable("date") Date date, @PathVariable("start_time") String time){
        Appointment validAppoint = appointRepo.findAppointmentByDoctorAndDateAndTime(id, date, time);
        boolean validate = true;
        if (validAppoint == null){
            validate = false;
        }return validate;
    }
    // Save appointment
    @PostMapping(value="/SetAppointment")
    public String saveAppointment(@RequestBody Appointment appoint){
        appointRepo.save(appoint);
        return "Appointment successfuly saved";
    }
}
