
package com.example.ndtelemedecine.DoctorAvailability;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;


@Entity
@IdClass(Availability.class)
public class Availability implements Serializable {

    @Id
    private int  doctor_id;
    @Id
    private String start_time;
    @Id
    private String end_time;
    @Id
    private int day_of_week;

    public void setdoctor_id(int doctor_id) {
        this.doctor_id= doctor_id;
    }
    public void setstart_time(String start_time){
        this.start_time = start_time;
    }
    public void setend_time(String end_time){
        this.end_time = end_time;
    }
    public void setday_of_week(int day_of_week){
        this.day_of_week = day_of_week;
    }

    public int get_doctor_id() {
        return this.doctor_id;
    }
    public String get_start_time(){
        return this.start_time;
    }
    public String get_end_time(){
        return this.end_time;
    }
    public int getday_of_week(){
        return this.day_of_week;
    }
    
}