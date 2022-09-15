package com.example.ndtelemedecine.Controllers;

import com.example.ndtelemedecine.Models.Availability;
import com.example.ndtelemedecine.Repositories.AvailabilityRepo;
import com.example.ndtelemedecine.Models.User;
import com.example.ndtelemedecine.Repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
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

        String start = avail.get_start_time();

        String end = avail.get_end_time();

        if (!user.getRole().equals("doctor")){
            return "User Is Not A Doctor!";
        }
        if(day >= 7 ){
            return "Incorrect Entry: Day of Week Entered was To High";
        }
        if(day <= 0 ){
            return "Incorrect Entry: Day of Week Entered was To Low";
        }
        if(end.compareTo(start) < 0){
            return "Incorrect Entry: End Time was Earlier than Start Time";
        }
        if(end.compareTo(start) == 0){
            return "Incorrect Entry: End and Start Times must be different";
        }
        availRepo.save(avail);
        return "Availability Set!";
    }
    // Sets an Availability For Doctor
    @GetMapping(value = "/GetAllDoctorAvailability")
    public List<Availability> doctorsAvailability(){
        User userFound = new User();
        userFound.setID(123);
        return availRepo.findByDoctorId(userFound.getID());
    }
    @GetMapping(value = "/GetAllDoctorsAvailabilities")
    public List<Availability> getDoctorsAvailabilities(){
        List<Availability> allAvailabilities = new ArrayList<>();
        for(int i = 1;i < 7;i++){
            allAvailabilities.addAll(availRepo.findBydayOfWeek(i));
        }
        return allAvailabilities;
    }
}
