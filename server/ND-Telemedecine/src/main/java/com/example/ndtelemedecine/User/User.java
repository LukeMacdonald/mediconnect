package com.example.ndtelemedecine.User;

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
    private long id;

    @Column
    private String  first_name;

    @Column
    private String  last_name;

    @Column
    private String  email;

    @Column
    private String  password;

    @Column(columnDefinition = "ENUM('patient', 'doctor', 'superuser')")
    @Enumerated(EnumType.STRING)
    private Role    role;

    // Below is not needed, as the db autogenerates it.
    // private int     id;

    public void setFirstName(String first_name) {
        this.first_name = first_name;
    }
    public void setLastName(String last_name) {
        this.last_name = last_name;
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
        }
    }

    public String getFirstName() {
        return this.first_name;
    }
    public String getLastName() {
        return this.last_name;
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
}
