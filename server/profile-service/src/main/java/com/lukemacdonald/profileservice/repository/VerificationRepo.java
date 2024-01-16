package com.lukemacdonald.profileservice.repository;

import com.lukemacdonald.profileservice.model.Verification;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VerificationRepo extends JpaRepository<Verification, Long> {

    Verification findByEmail(String email);

    boolean existsByEmail(String email);

}
