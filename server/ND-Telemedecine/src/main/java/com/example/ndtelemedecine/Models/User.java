package com.example.ndtelemedecine.Models;
import java.sql.Date;

import javax.persistence.*;
@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name="email")
    private String  email;

    @Column(name="password")
    private String  password;

    @Column(name = "role")
    public String role;

    @Column(name="first_name")
    private String  firstName;

    @Column(name="last_name")
    private String  lastName;

    @Column(name="dob")
    private Date dob;

    @Column(name="phone_number")
    private String phoneNumber;

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }


    public User(){}

    public User(String email, String password,String role){
        this.email = email;
        this.password = password;
    }
    public void setID(int id) {
        this.id = id;
    }
    public int getID(){
        return this.id;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getEmail() {
        return this.email;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getPassword() {
        return this.password;
    }
    public void setFirstName(String first_name) {
        this.firstName = first_name;
    }
    public String getFirstName() {
        return this.firstName;
    }
    public void setLastName(String last_name) {
        this.lastName = last_name;
    }
    public String getLastName() {
        return this.lastName;
    }
    public void setDob(Date dob) {
        this.dob = dob;
    }
    public Date getDob() {
        return this.dob;
    }
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    public String getPhoneNumber() {
        return this.phoneNumber;
    }
}

