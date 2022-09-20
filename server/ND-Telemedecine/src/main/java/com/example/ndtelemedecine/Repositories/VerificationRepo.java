package com.example.ndtelemedecine.Repositories;

import com.example.ndtelemedecine.Models.Verification;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VerificationRepo extends JpaRepository<Verification, Long>{

    Verification            findByEmail(String email);

    
}
