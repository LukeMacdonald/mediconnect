package com.example.prescription_service.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Prescription {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int prescriptionID;

    @Column
    private int patientID;

    @Column
    private int doctorID;

    @Column String name;

    @Column
    private Double dosage;

    @Column
    private int repeats;
    

    public int getprescriptionID() {
        return this.prescriptionID;
    }

    public void setprescriptionID(int prescriptionID) {
        this.prescriptionID = prescriptionID;
    }

    public int getPatientID() {
        return this.patientID;
    }

    public void setPatientID(int patientID) {
        this.patientID = patientID;
    }

    public int getDoctorID() {
        return this.doctorID;
    }

    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
    }

    public Double getDosage() {
        return this.dosage;
    }

    public void setDosage(Double dosage) {
        this.dosage = dosage;
    }

    public int getRepeats() {
        return this.repeats;
    }

    public void setRepeats(int repeats) {
        this.repeats = repeats;
    }


    public Prescription() {
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Prescription(int prescriptionID, int patientID, int doctorID, String name, Double dosage, int repeats) {
        this.prescriptionID = prescriptionID;
        this.patientID = patientID;
        this.doctorID = doctorID;
        this.name = name;
        this.dosage = dosage;
        this.repeats = repeats;
    }

}
