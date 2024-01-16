package com.lukemacdonald.profileservice.repository;

import com.lukemacdonald.profileservice.model.User;
import com.lukemacdonald.profileservice.model.enums.Role;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepo extends JpaRepository<User, Long> {

    User findByEmail(String email);

    User findById(int id);

    Boolean existsByEmail(String email);

    List<User> findAllByRole(String role);
}
