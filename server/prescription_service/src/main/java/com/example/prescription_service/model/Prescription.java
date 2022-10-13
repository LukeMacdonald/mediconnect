package com.example.prescription_service.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Prescription {
    @Id
    private int prescriptionId;

    @Column
    private int patientId;

    @Column
    private int doctorId;

    @Column
    private Double dosage;

    @Column
    private int repeats;
}
