package com.lukemacdonald.appointmentservice.repository;
import  com.lukemacdonald.appointmentservice.model.HealthStatus;


import org.springframework.data.jpa.repository.JpaRepository;

public interface HealthStatusRepo extends JpaRepository<HealthStatus, Long>{

    HealthStatus findHealthStatusByAppointmentId(int id);

}