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

    // {0th minute, 0th hour, every day (in the month), every month, every day (of the week)}
    @Scheduled(cron = "0 0 * * * *")
    public String notifyPatientBooking() {

        List<Appointment> upcomingAppointments = getUpcomingAppointments();

        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(sender);

        for (int i = 0; i < upcomingAppointments.size(); i++) {

            alertSinglePatient(upcomingAppointments.get(i));
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

    public void sendAppointmentNotification(Appointment appointment){
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(sender);

        String userEmail = appointment.getEmail();
        String emailSubj = "Reminder: Appointment scheduled at " + appointment.getTime() + " today";
        String emailBody = "This email is a reminder that you have an appointment on " + appointment.getDate() + 
        " at " + appointment.getTime() + " If you wish to update the appointment details, please do so in the app.";

        mailMessage.setTo(userEmail);
        mailMessage.setSubject(emailSubj);
        mailMessage.setText(emailBody);

        javaMailSender.send(mailMessage);
    }

    public void alertSinglePatient(Appointment appointment) {
        Appointment currentAppointment = appointment;

        // Setup email details
        String userEmail = appointment.getEmail();

        String emailSubj = "Reminder: Appointment scheduled at " + currentAppointment.getTime() + " today";
        String emailBody = "This email is a reminder that you have an appointment on " + currentAppointment.getDate() + " at " + 
        currentAppointment.getTime() + " If you wish to update the appointment details, please do so in the app.";

        // Send email
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(sender);

        mailMessage.setTo(userEmail);
        mailMessage.setSubject(emailSubj);
        mailMessage.setText(emailBody);
        javaMailSender.send(mailMessage);

    }
}