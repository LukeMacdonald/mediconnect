package com.example.ndtelemedecine;

import javax.annotation.sql.DataSourceDefinition;
import javax.persistence.*;

import net.bytebuddy.implementation.bytecode.assign.reference.GenericTypeAwareAssigner;

import lombok.Data;

@Entity
@Data
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column
    private String first_name;

    @Column
    private String last_name;

    @Column
    private String email;

    @Column
    private String password;

    @Column
    private String role;

    public int getID() {
        return id;
    }

    public String getFirst_Name() {
        return first_name;
    }
    
    public String getLast_Name() {
        return last_name;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getRole() {
        return role;
    }
}

