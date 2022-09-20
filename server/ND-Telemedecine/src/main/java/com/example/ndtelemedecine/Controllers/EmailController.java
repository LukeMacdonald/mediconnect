package com.example.ndtelemedecine.Controllers;
 
import com.example.ndtelemedecine.Models.EmailDetails;
import com.example.ndtelemedecine.Service.EmailService;
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
    public String
    sendMail(@RequestBody EmailDetails details){
        return emailService.sendSimpleMail(details);
    }
 
    // Sending email with attachment
    @PostMapping("/sendMailWithAttachment")
    public String sendMailWithAttachment(@RequestBody EmailDetails details){
        return emailService.sendMailWithAttachment(details);
    }
}
