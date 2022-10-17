package com.example.medication_service.model;

import java.util.Objects;

import javax.persistence.*;

@Entity
@Table(name = "medication")
public class Medication {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column
    private int userId;

    @Column
    private String name;

    @Column
    private double dosage;

    @Column
    private int repeat;


    public Medication() {
    }

    public Medication(int id, int userId, String name, double dosage, int repeat) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.dosage = dosage;
        this.repeat = repeat;
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

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getDosage() {
        return this.dosage;
    }

    public void setDosage(double dosage) {
        this.dosage = dosage;
    }

    public int getRepeat() {
        return this.repeat;
    }

    public void setRepeat(int repeat) {
        this.repeat = repeat;
    }

    public Medication id(int id) {
        setId(id);
        return this;
    }

    public Medication userId(int userId) {
        setUserId(userId);
        return this;
    }

    public Medication name(String name) {
        setName(name);
        return this;
    }

    public Medication dosage(double dosage) {
        setDosage(dosage);
        return this;
    }

    public Medication repeat(int repeat) {
        setRepeat(repeat);
        return this;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof Medication)) {
            return false;
        }
        Medication medication = (Medication) o;
        return id == medication.id && userId == medication.userId && Objects.equals(name, medication.name) && dosage == medication.dosage && repeat == medication.repeat;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, userId, name, dosage, repeat);
    }

    @Override
    public String toString() {
        return "{" +
            " id='" + getId() + "'" +
            ", userId='" + getUserId() + "'" +
            ", name='" + getName() + "'" +
            ", dosage='" + getDosage() + "'" +
            ", repeat='" + getRepeat() + "'" +
            "}";
    }

}
