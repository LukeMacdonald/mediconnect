package com.example.availability_service.controller;

import com.example.availability_service.model.Availability;
import com.example.availability_service.repository.AvailabilityRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class AvailabilityController {
    private final AvailabilityRepo availRepo;

    // Sets Availability For Doctor
    @PostMapping(value = "doctor/set/availability")
    public String availability(@RequestBody Availability avail){

        int day = avail.getDayOfWeek();
        if(day >= 7 ){
            return "Incorrect Entry: Day of Week Entered was To High";
        }
        else if(day <= 0 ){
            return "Incorrect Entry: Day of Week Entered was To Low";
        }
        else{
            availRepo.save(avail);
            return "Availability Set!";
        }
    }
    // Sets an Availability For Doctor
    @GetMapping(value = "/get/availabilities/{id}")
    public List<Availability> doctorsAvailability(@PathVariable("id") int id){
        return availRepo.findByDoctorId(id);
    }
    @GetMapping(value = "/get/all/availabilities")
    public List<Availability> getDoctorsAvailabilities(){
        return availRepo.findAll();
    }
}
