package com.lukemacdonald.availabilityservice.service;

import com.lukemacdonald.availabilityservice.model.Availability;
import com.lukemacdonald.availabilityservice.repository.AvailabilityRepo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Transactional
@Slf4j
@Service
public class AvailabilityServiceImpl implements AvailabilityService {

    private final AvailabilityRepo availabilityRepo;
    @Override
    public Availability set(Availability availability) {
        return availabilityRepo.save(availability);
    }

    @Override
    public List<Availability> finalAll() {
        return availabilityRepo.findAll();
    }

    @Override
    public List<Availability> findByDocker(int id) {
        return availabilityRepo.findAllByDoctorId(id);
    }

    @Override
    public List<Availability> findByDoctorAndDay(int id, int day) {
        return availabilityRepo.findAllByDoctorIdAndAndDayOfWeek(id, day);
    }


    @Override
    public void delete(Availability availability) {
        availabilityRepo.delete(availability);
    }
}
