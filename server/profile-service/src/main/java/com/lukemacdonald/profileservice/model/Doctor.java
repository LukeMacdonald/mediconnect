package com.lukemacdonald.profileservice.model;

public class Doctor extends User {

    private int code;

    public Doctor(String email,String password,String role,String confirmPassword,int code){
        setEmail(email);
        setPassword(password);
        setRole(role);
        setConfirmPassword(confirmPassword);
        setCode(code);
    }

    public int getCode() {
        return code;
    }
    public void setCode(int code) {
        this.code = code;
    }





}
