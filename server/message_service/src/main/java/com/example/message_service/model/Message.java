package com.example.message_service.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Entity
public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int messageID;

    @Column
    @NotBlank(message = "Message can't be empty")
    private String message;
    
    @Column
    @NotNull
    private int senderID;

    @Column
    @NotNull
    private int receiverID;

    @Column
    @NotNull
    private Date timestamp;

    public int getMessageID() {
        return messageID;
    }
    public int getSenderID() {
        return senderID;
    }
    public int getReceiverID() {
        return receiverID;
    }
    public String getMessage() {
        return message;
    }
    public Date getTimestamp() {
        return timestamp;
    }

    public void setMessageID(int messageID) {
        this.messageID = messageID;
    }
    public void setSenderID(int senderID) {
        this.senderID = senderID;
    }
    public void setReceiverID(int receiverID) {
        this.receiverID = receiverID;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }
}