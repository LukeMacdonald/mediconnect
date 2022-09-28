package com.example.availability_service.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;


@Entity
@IdClass(Availability.class)
@Table(name = "availability")
public class Availability implements Serializable {
    @Id
    private int  doctorId;
    @Id
    private String startTime;
    @Id
    private String endTime;
    @Id
    private int dayOfWeek;

    public void setdoctor_id(int doctor_id) {
        this.doctorId= doctor_id;
    }
    public void setstart_time(String start_time){
        this.startTime = start_time;
    }
    public void setend_time(String end_time){
        this.endTime = end_time;
    }
    public void setday_of_week(int day_of_week){
        this.dayOfWeek = day_of_week;
    }

    public int get_doctor_id() {
        return this.doctorId;
    }
    public String get_start_time(){
        return this.startTime;
    }
    public String get_end_time(){
        return this.endTime;
    }
    public int getday_of_week(){
        return this.dayOfWeek;
    }
}
