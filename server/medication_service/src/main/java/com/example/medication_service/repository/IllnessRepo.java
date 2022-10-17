package com.example.medication_service.repository;
import com.example.medication_service.model.Illness;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IllnessRepo extends JpaRepository<Illness, Long> {
    Illness findById(int id);
    List<Illness> findAllByUserId(int id);
}
