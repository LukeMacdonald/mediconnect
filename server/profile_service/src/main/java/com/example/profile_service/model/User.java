package com.example.profile_service.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
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

    @Email(message = "Email must be of correct format!")
    @NotBlank(message = "Email is required")
    @Column(unique = true)
    private String email;

    @Column
    @NotBlank(message = "Password field is required")
    private String password;

    @Column(columnDefinition = "ENUM('patient', 'doctor', 'superuser')")
    @Enumerated(EnumType.STRING)
    public Role role;
    @Column
    private String firstName;

    @Column
    private String lastName;

    @Column
    private Date dob;

    @Column
    private String phoneNumber;

    @Transient
    private String confirmPassword;

    public User() {
    }

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

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return this.email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    public String getPassword() {
        return this.password;
    }

    @Override
    public String getUsername() {
        return this.email;
    }

    public void setFirstName(String first_name) {
        this.firstName = first_name;
    }

    public String getFirstName() {
        return this.firstName;
    }

    public void setLastName(String last_name) {
        this.lastName = last_name;
    }

    public String getLastName() {
        return this.lastName;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public Date getDob() {
        return this.dob;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPhoneNumber() {
        return this.phoneNumber;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public void setRole(String role) {
        switch (role) {
            case "Patient":
            case "patient":
                this.role = Role.patient;
                break;
            case "Doctor":
            case "doctor":
                this.role = Role.doctor;
                break;
            case "Superuser":
            case "superuser":
            case "superadmin":
            case "Superadmin":
                this.role = Role.superuser;
                break;
            default:
                break;
        }
    }
    public String getRoleAuthority(){
        switch(this.role.getRoleName()){
            case "patient":
                return "ROLE_USER";
            case "doctor":
                return "ROLE_DOCTOR";
            case "superuser":
                return "ROLE_ADMIN";
            default:
                return "ERROR";

        }
    }

    public Role getRole() {
        return this.role;
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



