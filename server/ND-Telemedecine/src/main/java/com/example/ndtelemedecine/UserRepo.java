package com.example.ndtelemedecine;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User, Integer>{
    User findByEmailAndPasswordAndRole(String email,String password, String role);
}
