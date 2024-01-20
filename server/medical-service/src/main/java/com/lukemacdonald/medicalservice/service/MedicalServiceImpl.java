package com.lukemacdonald.medicalservice.service;

import com.lukemacdonald.medicalservice.model.Disability;
import com.lukemacdonald.medicalservice.model.Illness;
import com.lukemacdonald.medicalservice.model.MedicalHistory;
import com.lukemacdonald.medicalservice.model.Medication;
import com.lukemacdonald.medicalservice.repository.DisabilityRepo;
import com.lukemacdonald.medicalservice.repository.IllnessRepo;
import com.lukemacdonald.medicalservice.repository.MedicalHistoryRepo;
import com.lukemacdonald.medicalservice.repository.MedicationRepo;
import jakarta.ws.rs.NotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;


@RequiredArgsConstructor
@Transactional
@Slf4j
@Service
public class MedicalServiceImpl implements MedicalHistoryService{

    private final MedicalHistoryRepo medicalHistoryRepo;

    private final MedicationRepo medicationRepo;

    private final DisabilityRepo disabilityRepo;

    private final IllnessRepo illnessRepo;

    @Override
    public MedicalHistory saveHistory(MedicalHistory medicalHistory) {
        return medicalHistoryRepo.save(medicalHistory);
    }

    @Override
    public Disability saveDisability(Disability disability) {
        return disabilityRepo.save(disability);
    }

    @Override
    public Illness saveIllness(Illness illness) {
        return illnessRepo.save(illness);
    }

    @Override
    public Medication saveMedication(Medication medication) {
        return medicationRepo.save(medication);
    }
    @Override
    public void saveAll(MedicalHistory medicalHistory,
                        List<Disability> disabilities,
                        List<Illness> illnesses,
                        List<Medication> medications) {

        // Save MedicalHistory if not null
        if (medicalHistory != null) {
            medicalHistoryRepo.save(medicalHistory);
        }

        // Save Disabilities if not null and not empty
        if (disabilities != null && !disabilities.isEmpty()) {
            disabilityRepo.saveAll(disabilities);
        }

        // Save Illnesses if not null and not empty
        if (illnesses != null && !illnesses.isEmpty()) {
            illnessRepo.saveAll(illnesses);
        }

        // Save Medications if not null and not empty
        if (medications != null && !medications.isEmpty()) {
            medicationRepo.saveAll(medications);
        }
    }

    public HashMap<String, ?> getAll(int id) {
        HashMap<String, Object> fullHistory = new HashMap<>();

        try {
            // Validate the input ID
            if (id <= 0) {
                throw new IllegalArgumentException("Invalid user ID");
            }

            // Retrieve MedicalHistory
            MedicalHistory history = medicalHistoryRepo.findById(id);
            if (history == null) {
                log.error("Medical history not found for user with ID: " + id);
                throw new NotFoundException("Medical history not found for user with ID: " + id);
            }
            fullHistory.put("history", history);

            // Retrieve Disabilities
            List<Disability> disabilities = disabilityRepo.findAllByUserId(id);
            fullHistory.put("disabilities", disabilities);

            // Retrieve Illnesses
            List<Illness> illnesses = illnessRepo.findAllByUserId(id);
            fullHistory.put("illnesses", illnesses);

            // Retrieve Medications
            List<Medication> medications = medicationRepo.findAllByUserId(id);
            fullHistory.put("medications", medications);

        } catch (IllegalArgumentException e) {
            // Handle validation errors
            fullHistory.put("error", e.getMessage());
        } catch (NotFoundException e) {
            // Handle the case where the requested data is not found
            fullHistory.put("error", e.getMessage());
        } catch (Exception e) {
            // Handle other unexpected exceptions
            fullHistory.put("error", "An unexpected error occurred");
            log.error("An unexpected error occurred");
        }

        return fullHistory;
    }

    @Override
    public void deleteMedicalHistory(int id) {
        MedicalHistory history = medicalHistoryRepo.findById(id);
        medicalHistoryRepo.delete(history);
    }

    @Override
    public void deleteDisability(int id) {
        List<Disability> disabilities = disabilityRepo.findAllByUserId(id);
        disabilityRepo.deleteAll(disabilities);
    }

    @Override
    public void deleteIllness(int id) {
        List<Illness> illnesses = illnessRepo.findAllByUserId(id);
        illnessRepo.deleteAll(illnesses);

    }

    @Override
    public void deleteMedication(int id) {
        List<Medication> medications = medicationRepo.findAllByUserId(id);
        medicationRepo.deleteAll(medications);

    }

    @Override
    public void deleteAll(int id) {
        deleteMedicalHistory(id);
        deleteDisability(id);
        deleteIllness(id);
        deleteMedication(id);
    }
}
