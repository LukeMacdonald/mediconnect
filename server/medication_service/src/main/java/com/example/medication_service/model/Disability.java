package com.example.profile_service.model;

import javax.persistence.Column;
import javax.persistence.Id;

public class Disability {

    @Id
    private int id;

    @Column
    private int userId;

    @Column
    private String disability; 
    
}
