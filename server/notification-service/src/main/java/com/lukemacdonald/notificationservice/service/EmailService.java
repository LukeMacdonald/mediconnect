package com.lukemacdonald.notificationservice.service;

import com.lukemacdonald.notificationservice.dto.EmailDetails;

import javax.mail.MessagingException;

public interface EmailService {
    String sendSimpleMail(EmailDetails details);
    String sendMailWithAttachment(EmailDetails details);

    void sendHTMLMail(EmailDetails details) throws MessagingException;
}
