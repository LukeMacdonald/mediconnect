package com.example.medication_service.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.medication_service.model.User;

public interface UserRepo extends JpaRepository<User, Long> {

    @Query(value = "SELECT email FROM USERS WHERE USERS.id = :idToSearch", nativeQuery = true)
    UserProjection findUserById(@Param("idToSearch") int id);
}
