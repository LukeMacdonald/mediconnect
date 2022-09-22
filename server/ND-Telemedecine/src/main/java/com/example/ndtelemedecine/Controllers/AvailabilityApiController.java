package com.example.ndtelemedecine.Controllers;

import com.example.ndtelemedecine.Models.Availability;
import com.example.ndtelemedecine.Models.User;
import com.example.ndtelemedecine.Repositories.AvailabilityRepo;
import com.example.ndtelemedecine.Repositories.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class AvailabilityApiController {
    private final AvailabilityRepo availRepo;
    private final UserRepo userRepo;

    // Sets Availability For Doctor
    @PostMapping(value = "doctor/set/availability")
    public String availability(@RequestBody Availability avail){


        User user = userRepo.findById(avail.getDoctorId());

        int day = avail.getDayOfWeek();
        String role = user.getRole();
        if (!role.equals( "ROLE_DOCTOR")){
            return "User Is Not A Doctor!";
        }
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
