package com.example.booking_service.model;


import javax.persistence.*;


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



