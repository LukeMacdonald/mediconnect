package com.example.booking_service.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.example.booking_service.model.HealthStatus;
import com.example.booking_service.repository.HealthStatusRepo;
import com.example.booking_service.repository.UserRepo;

import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.*;


@RestController
@RequiredArgsConstructor
public class HealthStatusController {

    private final HealthStatusRepo HealthStatRepo;

    @GetMapping(value="/search/healthstatus/{id}")
    public HealthStatus getHealthStatus(@PathVariable("id") int id){
        HealthStatus validHealthStatus = HealthStatRepo.findHealthStatusById(id);
        return validHealthStatus;
    }
    // Save Health Status
    @PostMapping(value="/set/healthstatus")
    public String saveHealthStatus(@RequestBody HealthStatus healthstatus){
        HealthStatRepo.save(healthstatus);
        return "Health Status successfully set";
    }

}
