package com.lukemacdonald.medicalservice.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name="prescriptions")
public class Prescription {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column
    private int patientId;

    @Column
    private int doctorId;

    @Column
    String name;

    @Column
    private Double dosage;

    @Column
    private int repeats;
}