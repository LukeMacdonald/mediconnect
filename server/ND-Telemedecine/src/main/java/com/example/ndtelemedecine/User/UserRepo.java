package com.example.ndtelemedecine.User;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User, Long>  {
    List<User>      findByEmail(String email);
    List<User>      findByRole(Role role);
    User            findByEmailAndPassword(String email, String password);
    User            findById(int id);
}
