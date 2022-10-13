package com.example.prescription_service.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

// NOT SAME MODEL AS USER IN PROFILE_SERVICE

@Entity
@Table(name = "users")
public class User {

    @Id
    @Column
    private int id;

    @Column
    private String email;

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return this.email;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return this.id;
    }
}