package com.example.medication_service.model;

import java.util.Objects;

import javax.persistence.*;


@Entity
@Table(name = "disability")
public class Disability {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column
    private int userId;

    @Column
    private String disability; 
    

    public Disability() {
    }

    public Disability(int id, int userId, String disability) {
        this.id = id;
        this.userId = userId;
        this.disability = disability;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return this.userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getDisability() {
        return this.disability;
    }

    public void setDisability(String disability) {
        this.disability = disability;
    }

    public Disability id(int id) {
        setId(id);
        return this;
    }

    public Disability userId(int userId) {
        setUserId(userId);
        return this;
    }

    public Disability disability(String disability) {
        setDisability(disability);
        return this;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof Disability)) {
            return false;
        }
        Disability disability = (Disability) o;
        return id == disability.id && userId == disability.userId && Objects.equals(disability, disability.disability);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, userId, disability);
    }

    @Override
    public String toString() {
        return "{" +
            " id='" + getId() + "'" +
            ", userId='" + getUserId() + "'" +
            ", disability='" + getDisability() + "'" +
            "}";
    }

}
