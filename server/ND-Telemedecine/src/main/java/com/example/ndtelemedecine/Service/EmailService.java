package com.example.ndtelemedecine.Service;
 
import com.example.ndtelemedecine.Models.EmailDetails;
 
public interface EmailService {
    String sendSimpleMail(EmailDetails details);
    String sendMailWithAttachment(EmailDetails details);
}
