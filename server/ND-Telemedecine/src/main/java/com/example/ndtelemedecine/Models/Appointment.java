package com.example.ndtelemedecine.Models;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Appointment{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name="patient")
    private int  patient;
    @Column(name="doctor")
    private int doctor;
    @Column(name="date")
    private Date date;
    @Column(name="time")
    private String time;
    @Column(name="today")
    private String today;
    public void setId(int id){
        this.id = id;
    }
    public void setPatient(int patient) {
        this.patient = patient;
    }
    public void setDoctorId(int doctor) {
        this.doctor = doctor;
    }
    public void setDate(Date date) {
        this.date = date;
    }
    public void setTime(String time){
        this.time = time;
    }
    public void setToday(String today){
        this.today = today;
    }

    public int getId(){
        return this.id;
    }
    public int getPatient(){
        return this.patient;
    }
    public int getDoctor(){
        return this.doctor;
    }
    public Date getDate(){
        return this.date;
    }
    public String getTime(){
        return this.time;
    }
    public String getToday(){
        return this.today;
    }
}
