package com.example.profile_service.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Verification {

    @Id
    private String  email;

    @Column
    private int  code;

    public void setEmail(String email) {
        this.email = email;
    }
    public void setCode(int code) {
        this.code = code;
    }
    public String getEmail() {
        return this.email;
    }
    public int getCode() {
        return this.code;
    }


}
