package com.example.message_service.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;

@Entity
public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int messageID;

    @Column
    @NotBlank(message = "Message can't be empty")
    private String message;
    
    @Column
    @NotBlank(message = "sender ID is required")
    private int senderID;

    @Column
    @NotBlank(message = "receiver ID is required")
    private int receiverID;

    @Column
    @NotBlank(message = "timestamp is required")
    private Date timestamp;
}
