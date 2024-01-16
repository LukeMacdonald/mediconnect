package com.lukemacdonald.profileservice.model;

import lombok.Getter;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Setter;

import java.util.Random;

@Getter
@Entity
public class Verification {

    @Setter
    @Id
    private String  email;

    @Column
    private int  code;

    public Verification(String email){
        setEmail(email);
        setCode();
    }

    public Verification() {

    }

    public void setCode() {
        Random rand = new Random();
        this.code = rand.nextInt(999999);
    }

}
