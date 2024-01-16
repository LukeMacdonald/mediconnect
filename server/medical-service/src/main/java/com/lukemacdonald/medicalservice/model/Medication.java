package com.lukemacdonald.medicalservice.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;


@Entity
@Getter
@Setter
@Table(name = "medication")
public class Medication {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;


    @Column
    private int userId;

    @Column
    private String name;

    @Column
    private double dosage;

    @Column
    private int repeat;

}
