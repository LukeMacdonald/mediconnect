package com.example.booking_service.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class HealthStatus{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name="FeverOrChills")
    private Boolean FeverOrChills;

    @Column(name="Coughing")
    private Boolean Coughing;

    @Column(name="Headaches")
    private Boolean Headaches;

    @Column(name="Vomiting")
    private Boolean Vomiting;

    @Column(name="Fainting")
    private Boolean Fainting;

    @Column(name="description")
    private String description;

    public void setId(int id){
        this.id = id;
    }
    public void FeverOrChills(Boolean FeverOrChills) {
        this.FeverOrChills = FeverOrChills;
    }
    public void Coughing(Boolean Coughing) {
        this.Coughing = Coughing;
    }
    public void Headaches(Boolean Headaches) {
        this.Headaches = Headaches;
    }
    public void Vomiting(Boolean Vomiting) {
        this.Vomiting = Vomiting;
    }
    public void Fainting(Boolean Fainting) {
        this.Fainting = Fainting;
    }
    public void description(String description) {
        this.description = description;
    }

    public int getId(){
        return this.id;
    }
    public boolean getFeverOrChills(){
        return this.FeverOrChills;
    }
    public boolean getCoughing(){
        return this.Coughing;
    }
    public boolean getHeadaches(){
        return this.Headaches;
    }
    public boolean getVomiting(){
        return this.Vomiting;
    }
    public boolean getFainting(){
        return this.Fainting;
    }
    public String getDescription(){
        return this.description;
    }
}
