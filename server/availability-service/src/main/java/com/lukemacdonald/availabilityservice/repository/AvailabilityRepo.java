package com.lukemacdonald.availabilityservice.repository;

import com.lukemacdonald.availabilityservice.model.Availability;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AvailabilityRepo extends JpaRepository<Availability, Long> {

    List<Availability> findAllByDoctorId(int id);

    List<Availability> findAllByDoctorIdAndAndDayOfWeek(int id, int day);


}
