package com.example.medication_service.model;

import javax.persistence.*;


@Entity
@Table(name = "illness")
public class Illness {
    
    @Id
    private int id;

    @Column
    private int userId;

    @Column
    private String illness; 

}
