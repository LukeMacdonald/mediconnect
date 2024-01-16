package com.lukemacdonald.medicalservice.service;

import com.lukemacdonald.medicalservice.model.Prescription;

import java.util.List;

public interface PrescriptionService {

    Prescription save(Prescription prescription);

    Prescription update(Prescription prescription);

    List<Prescription> patientPrescriptions(int id);

    List<Prescription> all();

    void delete(Prescription prescription);


}
