package com.example.ndtelemedecine.User;

// This file describes the characteristics for all users.

public class User {

    private enum Role {
        patient,
        doctor,
        superuser
    }

    private String  first_name;
    private String  last_name;
    private String  email;
    private String  password;
    private Role    role;
    private int     id;
}
