package com.example.profile_service.repository;

import com.example.profile_service.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepo extends JpaRepository<User, Long>  {

    User findByEmail(String email);
    User            findById(int id);
    Boolean         existsByEmail(String email);
    User            findByEmailAndPassword(String email, String password);
}
