package com.example.communication_service.controller;
import com.example.communication_service.model.EmailDetails;
import com.example.communication_service.service.EmailService;

import com.example.communication_service.model.Verification;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class EmailController {

    final private EmailService emailService;

    // Sending a simple Email
    @PostMapping("/send/mail")
    public String sendMail(@RequestBody Verification verification){
        System.out.println(verification.getEmail());
        EmailDetails details = new EmailDetails();
        details.setRecipient(verification.getEmail());
        details.setMsgBody(
                    "Hello,"
                  + "\n\nThe following verification code must be provided to register,\n"
                  + verification.getCode()
                  + "\nBest Wishes,\nFrom the ND Telemedicine Management Team");
        details.setSubject("ND-Telemedicine Doctor Verification Code");

        return emailService.sendSimpleMail(details);
    }
    @PostMapping("/send/html/mail")
    public ResponseEntity<?> sendHTMLMail(@RequestBody Verification verification){
        EmailDetails details = new EmailDetails();
        Map<String, Object> response = new HashMap<>();
        details.setRecipient(verification.getEmail());
        details.setMsgBody(
                "<h1 style=\"text-align:center\">ND Telemedicine</h1>"
                        + "<h3>Congratulations you have been Verified by Our Team</h3>"
                        + "<p style=\"font-size:18px\",\"font-family:'Courier New'\">" +
                        "<br>Hello,<br><br>"
                        + "The following verification code must be provided to register:<br>"
                        + "</p>"
                        + "<p style=\"font-size:18px\",\"font-family:'Courier New'\",\"text-align:center\">"
                        + "<b>" + verification.getCode() + "</b>"
                        + "</p>"
                        + "<p style=\"font-size:18px\",\"font-family:'Courier New'\">"
                        + "Best Wishes,<br>"
                        + "From the ND Telemedicine Management Team"
                        + "</p>");
        details.setSubject("ND-Telemedicine Doctor Verification Code");
        try{
            emailService.sendHTMLMail(details);
        }catch(Exception e){
            response.put("error",e.getMessage());
            return new ResponseEntity<>(response,HttpStatus.BAD_REQUEST);
        }
        response.put("message","Email Sent");
        return new ResponseEntity<>(response,HttpStatus.ACCEPTED);
    }
    // Sending email with attachment
    @PostMapping("/sendMailWithAttachment")
    public String sendMailWithAttachment(@RequestBody EmailDetails details){
        return emailService.sendMailWithAttachment(details);
    }
}
