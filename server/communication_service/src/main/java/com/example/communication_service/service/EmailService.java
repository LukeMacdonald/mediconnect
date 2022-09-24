package com.example.communication_service.service;
import com.example.communication_service.model.EmailDetails;

public interface EmailService {
    String sendSimpleMail(EmailDetails details);
    String sendMailWithAttachment(EmailDetails details);
}
