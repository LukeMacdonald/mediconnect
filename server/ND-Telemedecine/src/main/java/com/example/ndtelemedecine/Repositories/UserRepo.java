package com.example.ndtelemedecine.Repositories;

import com.example.ndtelemedecine.Models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User, Long>  {

    User            findByEmail(String email);
    User            findById(int id);
    Boolean         existsByEmail(String email);
    User            findByEmailAndPassword(String email, String password);



}
