package com.example.profile_service.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Id;

public class HealthInformation extends User{
    
    @Id
    private int id; 

    @Column
    private Boolean smoke;

    @Column
    private Boolean drink;

    @Column
    private Boolean medication;

}
