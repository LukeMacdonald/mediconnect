package com.example.communication_service.controller;
import com.example.communication_service.model.EmailDetails;
import com.example.communication_service.service.EmailService;

import com.example.profile_service.model.Verification;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class EmailController {

    final private EmailService emailService;

    // Sending a simple Email
    @PostMapping("/sendMail")
    public String sendMail(@RequestBody Verification verification){
        EmailDetails details = new EmailDetails();
        details.setRecipient(verification.getEmail());
        details.setMsgBody(
                    "Hello,"
                  + "\n\nThe following verification codemust be provided to register,\n$"
                  + verification.getCode()
                  + "\nBest Wishes,\nFrom the ND Telemedicine Management Team");

        details.setSubject("ND-Telemedicine Doctor Verification Code");

        return emailService.sendSimpleMail(details);
    }
    // Sending email with attachment
    @PostMapping("/sendMailWithAttachment")
    public String sendMailWithAttachment(@RequestBody EmailDetails details){
        return emailService.sendMailWithAttachment(details);
    }
}
