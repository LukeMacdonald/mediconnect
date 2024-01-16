package com.lukemacdonald.medicalservice.service;

import com.lukemacdonald.medicalservice.model.Disability;
import com.lukemacdonald.medicalservice.model.Illness;
import com.lukemacdonald.medicalservice.model.MedicalHistory;
import com.lukemacdonald.medicalservice.model.Medication;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

public interface MedicalHistoryService {

    MedicalHistory saveHistory(MedicalHistory medicalHistory);

    Disability saveDisability(Disability disability);

    Illness saveIllness(Illness illness);

    Medication saveMedication(Medication medication);

    void saveAll(MedicalHistory medicalHistory, List<Disability> disabilities, List<Illness> illnesses, List<Medication> medications);

    HashMap<String, ?> getAll(int id);

    void deleteMedicalHistory(int id);

    void deleteDisability(int id);

    void deleteIllness(int id);

    void deleteMedication(int id);

    void deleteAll(int id);

}
