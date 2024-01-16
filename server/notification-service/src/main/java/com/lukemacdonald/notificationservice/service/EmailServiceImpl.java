package com.lukemacdonald.notificationservice.service;

import com.lukemacdonald.notificationservice.dto.EmailDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.File;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmailServiceImpl implements EmailService {

    private final JavaMailSender emailSender;

    @Value("${spring.mail.username}") private String sender;

    public String sendSimpleMail(EmailDetails details)
    {
        try {
            // Creating a simple mail message
            SimpleMailMessage mailMessage
                    = new SimpleMailMessage();

            // Setting up necessary details
            mailMessage.setFrom(sender);
            mailMessage.setTo(details.getRecipient());
            mailMessage.setText(details.getMsgBody());
            mailMessage.setSubject(details.getSubject());

            emailSender.send(mailMessage);
            System.out.println("Out");
            return "Mail Sent Successfully...";
        }

        // Catch block to handle the exceptions
        catch (Exception e) {
            return e.getMessage();
        }
    }

    public void sendHTMLMail(EmailDetails details) throws MessagingException {

        MimeMessage msg = emailSender.createMimeMessage();
        log.info("email request received");
        MimeMessageHelper helper = new MimeMessageHelper(msg, true);

        helper.setSubject(details.getSubject());



        // Setting up necessary details
        helper.setFrom(sender);
        helper.setTo(details.getRecipient());
        helper.setText(details.getMsgBody(),true);

        // Sending the mail
//        emailSender.send(msg);

        log.info("email message sent to {}", details.getRecipient());

    }

    public String sendMailWithAttachment(EmailDetails details)
    {
        // Creating a mime message
        MimeMessage mimeMessage
                = emailSender.createMimeMessage();
        MimeMessageHelper mimeMessageHelper;

        try {
            // Setting multipart as true for attachments to be send
            mimeMessageHelper
                    = new MimeMessageHelper(mimeMessage, true);
            mimeMessageHelper.setFrom(sender);
            mimeMessageHelper.setTo(details.getRecipient());
            mimeMessageHelper.setText(details.getMsgBody(), "text/html");
            mimeMessageHelper.setSubject(
                    details.getSubject());
            // Adding the attachment
            FileSystemResource file
                    = new FileSystemResource(
                    new File(details.getAttachment()));
            mimeMessageHelper.addAttachment(
                    file.getFilename(), file);
            // Sending the mail
            emailSender.send(mimeMessage);
        }

        // Catch block to handle MessagingException
        catch (MessagingException e) {

            // Display message when exception occurred
            return "Error while sending mail!";
        }
        return "Mail Sent Successfully...";
    }
}
