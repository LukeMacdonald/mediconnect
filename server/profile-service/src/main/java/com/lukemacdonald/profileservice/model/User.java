package com.lukemacdonald.profileservice.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import jakarta.persistence.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import java.sql.Date;
import java.util.Collection;



@Entity
@Table(name = "users")
public class User implements UserDetails {

    @NotNull
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Getter
    @Setter
    @Email(message = "Email must be of correct format!")
    @NotBlank(message = "Email is required")
    @Column(unique = true)
    private String email;

    @Setter
    @Getter
    @Column
    @NotBlank(message = "Password field is required")
    private String password;

//    @Getter
//    @Column(columnDefinition = "ENUM('patient', 'doctor', 'admin')")
//    @Enumerated(EnumType.STRING)

    @Getter
    @Column(name = "role", nullable = false)
    private String role;

    @Getter
    @Setter
    @Column
    private String firstName;

    @Getter
    @Setter
    @Column
    private String lastName;

    @Setter
    @Getter
    @Column
    private Date dob;

    @Setter
    @Getter
    @Column
    private String phoneNumber;

    @Setter
    @Getter
    @Transient
    private String confirmPassword;


    public User() {}

    public User(String email, String password, String role, String confirmPassword) {
        this.email = email;
        this.password = password;
        setRole(role);
        this.confirmPassword = confirmPassword;
    }

    public User(String email, String password, String role) {
        this.email = email;
        this.password = password;
        setRole(role);
    }

    public void setID(int id) {
        this.id = id;
    }

    public int getID() {
        return this.id;
    }

    public void setRole(String role) {
        switch (role) {
            case "Patient":
            case "patient":
                this.role = "patient";
                break;
            case "Doctor":
            case "doctor":
                this.role = "doctor";
                break;
            case "Admin":
            case "admin":
                this.role = "admin";
                break;
            default:
                break;
        }
    }
    public String getRoleAuthority(){
        return switch (this.role) {
            case "patient" -> "ROLE_USER";
            case "doctor" -> "ROLE_DOCTOR";
            case "admin" -> "ROLE_ADMIN";
            default -> "ERROR";
        };
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String getUsername() {
        return this.email;
    }

    @Override
    @JsonIgnore
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    @JsonIgnore
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    @JsonIgnore
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    @JsonIgnore
    public boolean isEnabled() {
        return true;
    }
}
