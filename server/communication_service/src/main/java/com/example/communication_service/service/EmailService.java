package com.example.communication_service.service;
import com.example.communication_service.model.EmailDetails;

import javax.mail.MessagingException;

public interface EmailService {
    String sendSimpleMail(EmailDetails details);
    String sendMailWithAttachment(EmailDetails details);

    void sendHTMLMail(EmailDetails details) throws MessagingException;
}
