package com.example.medication_service.model;

import java.util.Objects;

import javax.persistence.*;

@Entity
@Table(name = "illness")
public class Illness {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column
    private int userId;

    @Column
    private String illness; 


    public Illness() {
    }

    public Illness(int id, int userId, String illness) {
        this.id = id;
        this.userId = userId;
        this.illness = illness;
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

    public String getIllness() {
        return this.illness;
    }

    public void setIllness(String illness) {
        this.illness = illness;
    }

    public Illness id(int id) {
        setId(id);
        return this;
    }

    public Illness userId(int userId) {
        setUserId(userId);
        return this;
    }

    public Illness illness(String illness) {
        setIllness(illness);
        return this;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof Illness)) {
            return false;
        }
        Illness illness = (Illness) o;
        return id == illness.id && userId == illness.userId && Objects.equals(illness, illness.illness);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, userId, illness);
    }

    @Override
    public String toString() {
        return "{" +
            " id='" + getId() + "'" +
            ", userId='" + getUserId() + "'" +
            ", illness='" + getIllness() + "'" +
            "}";
    }

}
