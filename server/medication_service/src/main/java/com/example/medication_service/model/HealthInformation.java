package com.example.medication_service.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.*;


@Entity
@Table(name = "healthinformation")
public class HealthInformation{
    
    @Id
    private int id; 

    @Column
    private Boolean smoke;

    @Column
    private Boolean drink;

    @Column
    private Boolean medication;

}
