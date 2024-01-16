package com.lukemacdonald.medicalservice.repository;

import com.lukemacdonald.medicalservice.model.Illness;
import com.lukemacdonald.medicalservice.model.MedicalHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IllnessRepo extends CrudRepository<Illness, Long> {
    Illness findById(int id);
    List<Illness> findAllByUserId(int id);
}
