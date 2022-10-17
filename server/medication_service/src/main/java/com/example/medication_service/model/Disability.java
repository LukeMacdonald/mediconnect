package com.example.medication_service.model;

import javax.persistence.*;


@Entity
@Table(name = "disability")
public class Disability {

    @Id
    private int id;

    @Column
    private int userId;

    @Column
    private String disability; 
    
}
