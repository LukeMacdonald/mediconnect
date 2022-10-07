package com.example.booking_service.service;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.booking_service.model.Appointment;
import com.example.booking_service.repository.AppointmentRepo;
import com.example.booking_service.repository.UserRepo;

import lombok.NoArgsConstructor;

@Component
@NoArgsConstructor
public class NotificationService {
    
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private AppointmentRepo appointRepo;
    
    @Autowired
    private JavaMailSender javaMailSender;

    @Value("${spring.mail.username}") private String sender;

    @Scheduled(cron = "5 * * * * *")
    public String notifyPatientBooking() {

        List<Appointment> upcomingAppointments = getUpcomingAppointments();

        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(sender);

        for (int i = 0; i < upcomingAppointments.size(); i++) {

            Appointment currentAppointment = upcomingAppointments.get(i);

            System.out.println(currentAppointment);

            // Send notification emails
            String userEmail = "";
            try {
                userEmail = userRepo.findUserById(currentAppointment.getPatient()).getEmail();
            } catch (Exception e) {
                // This should never occur in the first place, but as a safety measure anyway:
                System.out.println("User with ID: " + currentAppointment.getPatient() + " could not be found. Skipping...");
                continue;
            }
            String emailSubj = "Reminder: Appointment scheduled at " + currentAppointment.getTime() + " today";
            String emailBody = "This email is a reminder that you have an appointment on " + currentAppointment.getDate() + " at " + 
                currentAppointment.getTime() + " If you wish to update the appointment details, please do so in the app.";


            System.out.println(userEmail);
            mailMessage.setTo(userEmail);
            mailMessage.setSubject(emailSubj);
            mailMessage.setText(emailBody);

            javaMailSender.send(mailMessage);
            System.out.println("Mail sent to " + currentAppointment.getPatient());
            System.out.println("\n\n");
        }

        SimpleDateFormat formDate = new SimpleDateFormat("dd-MM-yyyy");
        String strDate = formDate.format(new Date());

        String response = upcomingAppointments.size() + " patients have been notified about their appointments on " + strDate;

        return response;
    }

    public List<Appointment> getUpcomingAppointments() {
        // Parse date to just dd/mm/YYYY
        SimpleDateFormat formDate = new SimpleDateFormat("dd-MM-yyyy");
        String today = formDate.format(new Date());
        return appointRepo.findAppointmentByDate(java.sql.Date.valueOf(today));
    }
}