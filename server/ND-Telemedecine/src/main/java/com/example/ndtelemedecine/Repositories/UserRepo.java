package com.example.ndtelemedecine.Repositories;

import java.util.List;

import com.example.ndtelemedecine.Models.Role;
import com.example.ndtelemedecine.Models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User, Long>  {
    List<User>      findByEmail(String email);
    List<User>      findByRole(Role role);
    User            findByEmailAndPassword(String email, String password);
    User            findById(int id);

    User findUserByEmail(String email);
}
