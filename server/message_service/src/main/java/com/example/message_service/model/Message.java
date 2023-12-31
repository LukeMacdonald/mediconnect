package com.example.message_service.model;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss", iso = DateTimeFormat.ISO.DATE_TIME)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime timestamp;



    @Column
    private boolean viewed;


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
    public LocalDateTime getTimestamp() {
        return timestamp;
    }
    public boolean isViewed() { return viewed; }


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
    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }
    public void setViewed(boolean viewed) {this.viewed = viewed;}
}