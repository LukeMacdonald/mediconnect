package com.example.communication_service.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Random;

@Entity
public class Verification {

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


    public void setEmail(String email) {
        this.email = email;
    }
    public void setCode() {
        Random rand = new Random();
        this.code = rand.nextInt(999999);
    }
    public String getEmail() {
        return this.email;
    }
    public int getCode() {
        return this.code;
    }

}
