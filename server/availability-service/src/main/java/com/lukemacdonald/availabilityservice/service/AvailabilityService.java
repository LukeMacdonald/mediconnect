package com.lukemacdonald.availabilityservice.service;

import com.lukemacdonald.availabilityservice.model.Availability;

import java.util.List;

public interface AvailabilityService {

    Availability set(Availability availability);

    List<Availability> finalAll();

    List<Availability> findByDocker(int id);

    List<Availability> findByDoctorAndDay(int id, int day);

    void delete(Availability availability);
}
