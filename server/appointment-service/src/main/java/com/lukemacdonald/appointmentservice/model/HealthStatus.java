package com.lukemacdonald.appointmentservice.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class HealthStatus{

    @Id
    private int appointmentId;

    @Column
    private Boolean feverOrChills;

    @Column
    private Boolean coughing;

    @Column
    private Boolean headaches;

    @Column
    private Boolean vomiting;

    @Column
    private Boolean fainting;

    @Column
    private String description;

}
