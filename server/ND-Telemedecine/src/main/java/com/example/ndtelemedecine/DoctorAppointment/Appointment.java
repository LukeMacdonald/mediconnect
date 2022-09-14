package com.example.ndtelemedecine.DoctorAppointment;

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

    @Column(name="patient_id")
    private int  patientId;

    @Column(name="doctor_id")
    private int  doctorId;

    @Column(name="date")
    private Date date;

    @Column(name="time")
    private String time;

    @Column(name="current_time")
    private String currentTime;

    public void setAppointId(int id){
        this.id = id;
    }
    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }
    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }
    public void setDate(Date date) {
        this.date = date;
    }
    public void setTime(String time){
        this.time = time;
    }
    public void setCurTime(String curTime){
        this.currentTime = curTime;
    }

    public int getAppointId(){
        return this.id;
    }
    public int getPatientId(){
        return this.patientId;
    }
    public int getDoctorId(){
        return this.doctorId;
    }
    public Date getDate(){
        return this.date;
    }
    public String getTime(){
        return this.time;
    }
    public String getCurTime(){
        return this.currentTime;
    }
}
