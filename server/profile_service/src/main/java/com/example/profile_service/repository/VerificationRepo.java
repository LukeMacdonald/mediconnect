package com.example.profile_service.repository;

import com.example.profile_service.model.Verification;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VerificationRepo extends JpaRepository<Verification, Long>{

    Verification findByEmail(String email);
    void deleteByEmail(String email);

}