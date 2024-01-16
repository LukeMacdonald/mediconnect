package com.example.profile_service.repository;

import com.example.profile_service.model.Role;
import com.example.profile_service.model.User;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepo extends JpaRepository<User, Integer>  {

    User            findByEmail(String email);
    List<User>      findByRole(Role role);
    User            findById(int id);
    Boolean         existsByEmail(String email);
    User            findByEmailAndPassword(String email, String password);
    List<User>      findAllByRole(Role role);
    
}
