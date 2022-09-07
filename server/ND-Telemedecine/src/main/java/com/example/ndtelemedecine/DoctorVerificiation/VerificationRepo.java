package com.example.ndtelemedecine.DoctorVerificiation;

import org.springframework.data.jpa.repository.JpaRepository;

public interface VerificationRepo extends JpaRepository<Verification, Long>{

    Verification            findByEmail(String email);

    
}
