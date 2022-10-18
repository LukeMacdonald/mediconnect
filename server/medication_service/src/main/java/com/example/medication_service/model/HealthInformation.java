package com.example.medication_service.model;

import java.util.Objects;

import javax.persistence.*;


@Entity
@Table(name = "healthinformation")
public class HealthInformation{
    
    @Id
    private int id; 

    @Column
    private Boolean smoke;

    @Column
    private Boolean drink;

    public HealthInformation() {
    }

    public HealthInformation(int id, Boolean smoke, Boolean drink) {
        this.id = id;
        this.smoke = smoke;
        this.drink = drink;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Boolean isSmoke() {
        return this.smoke;
    }

    public Boolean getSmoke() {
        return this.smoke;
    }

    public void setSmoke(Boolean smoke) {
        this.smoke = smoke;
    }

    public Boolean isDrink() {
        return this.drink;
    }

    public Boolean getDrink() {
        return this.drink;
    }

    public void setDrink(Boolean drink) {
        this.drink = drink;
    }

    public HealthInformation id(int id) {
        setId(id);
        return this;
    }

    public HealthInformation smoke(Boolean smoke) {
        setSmoke(smoke);
        return this;
    }

    public HealthInformation drink(Boolean drink) {
        setDrink(drink);
        return this;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof HealthInformation)) {
            return false;
        }
        HealthInformation healthInformation = (HealthInformation) o;
        return id == healthInformation.id && Objects.equals(smoke, healthInformation.smoke) && Objects.equals(drink, healthInformation.drink);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, smoke, drink);
    }

    @Override
    public String toString() {
        return "{" +
            " id='" + getId() + "'" +
            ", smoke='" + isSmoke() + "'" +
            ", drink='" + isDrink() + "'" +
            "}";
    }

}
