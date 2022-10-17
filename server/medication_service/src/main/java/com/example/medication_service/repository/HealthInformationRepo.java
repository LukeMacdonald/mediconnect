package com.example.profile_service.repository;
import com.example.profile_service.model.HealthInformation;
import com.example.profile_service.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HealthInformationRepo extends JpaRepository<User, Long> {
    HealthInformation findById(int id);
}
