package com.example.ndtelemedecine.Models;

import com.example.ndtelemedecine.Models.Role;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


// This file describes the characteristics for all users.

@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name="first_name")
    private String  firstName;

    @Column(name="last_name")
    private String  lastName;

    @Column(name="dob")
    private Date dob;

    @Column(name="phone_number")
    private String phoneNumber;

    @Column(name="email")
    private String  email;

    @Column(name="password")
    private String  password;

    @Column(columnDefinition = "ENUM('patient', 'doctor', 'superuser')")
    @Enumerated(EnumType.STRING)
    private Role role;

    public User(){}

    public User(String email, String password,String role){
        this.email = email;
        this.password = password;
        setRole(role);
    }

    public void setFirstName(String first_name) {
        this.firstName = first_name;
    }
    public void setLastName(String last_name) {
        this.lastName = last_name;
    }
    public void setDob(Date dob) {
        this.dob = dob;
    }
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    
    public void setRole(String role) {
        switch (role) {
            case "patient":
                this.role = Role.patient;
                break;

            case "doctor":
                this.role = Role.doctor;
                break;

            case "superuser":
                this.role = Role.superuser;
                break;
            
            // TODO: Add some sort of check if an invalid role was given.
            default:
                break;
        }
    }

    // This particular function is used for updating a user by setting the user's ID to what's passed in as a parameter.
    public void setID(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return this.firstName;
    }
    public String getLastName() {
        return this.lastName;
    }
    public Date getDob() {
        return this.dob;
    }
    public String getPhoneNumber() {
        return this.phoneNumber;
    }
    public String getEmail() {
        return this.email;
    }
    public String getPassword() {
        return this.password;
    }

    public Role getRole() {
        return this.role;
    }
    public int getID(){
        return this.id;
    }
}
