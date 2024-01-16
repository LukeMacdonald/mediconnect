package com.lukemacdonald.medicalservice.model;


import lombok.Getter;
import lombok.Setter;

import jakarta.persistence.*;
import java.util.List;
import java.util.Objects;

@Setter
@Getter
@Entity
@Table(name = "medicalhistory")
public class MedicalHistory {

    @Id
    private int id;

    @Column
    private Boolean smoke;

    @Column
    private Boolean drink;

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof MedicalHistory healthInformation)) {
            return false;
        }
        return id ==
                healthInformation.id &&
                Objects.equals(smoke, healthInformation.smoke) &&
                Objects.equals(drink, healthInformation.drink);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, smoke, drink);
    }

    @Override
    public String toString() {
        return "{" +
                " id='" + getId() + "'" +
                ", smoke='" + getSmoke() + "'" +
                ", drink='" + getDrink() + "'" +
                "}";
    }
}
