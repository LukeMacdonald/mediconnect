package com.lukemacdonald.availabilityservice.controller;

import com.lukemacdonald.availabilityservice.model.Availability;
import com.lukemacdonald.availabilityservice.repository.AvailabilityRepo;
import com.lukemacdonald.availabilityservice.service.AvailabilityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("availability")
public class AvailabilityController {

    private final AvailabilityService availabilityService;

    // Sets Availability For Doctor
    @PostMapping(value = "/save")
    public ResponseEntity<?> availability(@RequestBody Availability avail){

        int day = avail.getDayOfWeek();
        if(day >= 7 ){
            return ResponseEntity.badRequest().body("Incorrect Entry: Day of Week Entered was To High");
        }
        else if(day <= 0 ){
            return ResponseEntity.badRequest().body("Incorrect Entry: Day of Week Entered was To Low");
        }
        else{
            availabilityService.set(avail);
            return ResponseEntity.ok().body("Availability Set!");
        }
    }
    // Sets an Availability For Doctor
    @GetMapping(value = "/get")
    public ResponseEntity<?> doctorsAvailability(@RequestParam int id){
        List<Availability> availabilities = availabilityService.findByDocker(id);
        if (availabilities.isEmpty()){
            return ResponseEntity.status(204).body("No Availabilities");
        }
        return ResponseEntity.ok().body(availabilities);
    }

    @GetMapping(value = "/check")
    public ResponseEntity<?> doctorsAvailabilityCheck(@RequestParam int id, @RequestParam int day){
        List<Availability> availabilities = availabilityService.findByDoctorAndDay(id, day);
        if (availabilities.isEmpty()){
            return ResponseEntity.status(404).body("No Availabilities Found");
        }
        return ResponseEntity.ok(availabilities);

    }

    @GetMapping("/all")
    public ResponseEntity<List<Availability>> getAll(){
        return ResponseEntity.ok(availabilityService.finalAll());
    }

    // Remove an Avaiability
    @DeleteMapping(value = "/delete")
    public void removeAvailability(@RequestBody Availability avail){
        availabilityService.delete(avail);
    }
}