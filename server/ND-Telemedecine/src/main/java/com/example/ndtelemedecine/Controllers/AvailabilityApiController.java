package com.example.ndtelemedecine.Controllers;

import com.example.ndtelemedecine.Models.Availability;
import com.example.ndtelemedecine.Models.Role;
import com.example.ndtelemedecine.Repositories.AvailabilityRepo;
import com.example.ndtelemedecine.Models.User;
import com.example.ndtelemedecine.Repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@RestController
public class AvailabilityApiController {

    @Autowired
    private AvailabilityRepo availRepo;

    @Autowired
    private UserRepo userRepo;
    // Sets a Availability For Doctor
    @PostMapping(value = "/SetMultipleDoctorAvailability")
    public String availability(@RequestBody List<Availability> avail){
        availRepo.saveAll(avail);
        return "Set Doctor Availability";
    }
    // Sets a Availability For Doctor
    @PostMapping(value = "/SetDoctorAvailability")
    public String availability(@RequestBody Availability avail){

        User user = userRepo.findById(avail.get_doctor_id());

        int day = avail.getday_of_week();

        if (user.getRole() != Role.doctor){
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
    @GetMapping(value = "/GetAllDoctorAvailability/{id}")
    public List<Availability> doctorsAvailability(@PathVariable("id") int id){
        return availRepo.findByDoctorId(id);
    }
    @GetMapping(value = "/GetAllDoctorsAvailabilities")
    public List<Availability> getDoctorsAvailabilities(){
        return availRepo.findAll();
    }
}
