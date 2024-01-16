package com.lukemacdonald.profileservice.controller;

import com.lukemacdonald.profileservice.messaging.EmailMessageProducer;
import com.lukemacdonald.profileservice.model.EmailMessage;
import com.lukemacdonald.profileservice.model.Verification;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("mail")
@RequiredArgsConstructor
public class EmailController {

    private final EmailMessageProducer emailMessageProducer;

    // Sending a simple Email
    @PostMapping("/send")
    public String sendMail(@RequestBody Verification verification){

        EmailMessage details = new EmailMessage();

        details.setRecipient(verification.getEmail());

        details.setMsgBody(
                "Hello,"
                        + "\n\nThe following verification code must be provided to register,\n"
                        + verification.getCode()
                        + "\nBest Wishes,\nFrom the ND Telemedicine Management Team");
        details.setSubject("ND-Telemedicine Doctor Verification Code");

        emailMessageProducer.sendMessage(details);

        return "Message Sent";
    }

    @PostMapping("/send-html")
    public ResponseEntity<?> sendHTMLMail(@RequestBody Verification verification){
        EmailMessage details = new EmailMessage();
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
            emailMessageProducer.sendMessage(details);
        }catch(Exception e){
            response.put("error",e.getMessage());
            return new ResponseEntity<>(response,HttpStatus.BAD_REQUEST);
        }
        response.put("message","Email Sent");
        return new ResponseEntity<>(response,HttpStatus.ACCEPTED);
    }
}
