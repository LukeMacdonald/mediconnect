package com.lukemacdonald.availabilityservice.model;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import jakarta.persistence.*;


@Setter
@Getter
@Entity
@Table(name = "availability")
public class Availability {


    @Id
    @NotNull
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column
    @NotBlank
    private int  doctorId;

    @Column
    @NotBlank
    private String startTime;

    @Column
    @NotBlank
    private String endTime;

    @Column
    @NotBlank
    private int dayOfWeek;
}
