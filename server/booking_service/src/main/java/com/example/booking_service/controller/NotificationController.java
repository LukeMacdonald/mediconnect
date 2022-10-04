package com.example.booking_service.controller;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Value;


import com.example.booking_service.model.Appointment;
import com.example.booking_service.repository.AppointmentRepo;
import com.example.booking_service.repository.UserRepo;


@RestController
public class NotificationController {

    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private AppointmentRepo   appointRepo;

    @Autowired
    private UserRepo          userRepo;

    @Value("${spring.mail.username}") private String sender;

    // Get list of appointments by the current date
    @GetMapping(value="/search/appointment/date")
    public List<Appointment> getUpcomingAppointments() {

        // Parse date to just dd/mm/YYYY
        Date in = new Date();
        LocalDateTime ldt = LocalDateTime.ofInstant(in.toInstant(), ZoneId.systemDefault());
        Date out = Date.from(ldt.atZone(ZoneId.systemDefault()).toInstant());
        
        List<Appointment> upcomingAppointments = appointRepo.findAppointmentByDate(out);

        for (int i = 0; i < upcomingAppointments.size(); i++) {
            System.out.println(upcomingAppointments.get(i));
        }

        return upcomingAppointments;
    }

    // Custom Controller method that force notifies patients
    @GetMapping(value="/notifypatients")
    public String notifyPatientBooking() {

        List<Appointment> upcomingAppointments = getUpcomingAppointments();

        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(sender);

        for (int i = 0; i < upcomingAppointments.size(); i++) {

            Appointment currentAppointment = upcomingAppointments.get(i);

            System.out.println(currentAppointment);

            // Send notification emails
            String userEmail = userRepo.findUserById(currentAppointment.getPatient()).getEmail();
            String emailSubj = "Reminder: Appointment scheduled at " + currentAppointment.getTime() + " today";
            String emailBody = "This email is a reminder that you have an appointment on " + currentAppointment.getDate() + " at " + 
                currentAppointment.getTime() + " If you wish to update the appointment details, please do so in the app.";


            System.out.println(userEmail);
            mailMessage.setTo(userEmail);
            mailMessage.setSubject(emailSubj);
            mailMessage.setText(emailBody);

            javaMailSender.send(mailMessage);
            System.out.println("Mail sent to " + currentAppointment.getPatient());
        }

        String response = upcomingAppointments.size() + " patients have been notified about their appointments on " + new Date();

        return response;
    }
}
