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
import com.example.booking_service.service.NotificationService;


@RestController
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    // Get list of appointments by the current date
    @GetMapping(value="/search/appointment/date")
    public List<Appointment> getUpcomingAppointments() {

        return notificationService.getUpcomingAppointments();
    }

    // Custom Controller method that force notifies patients
    @GetMapping(value="/notifypatients")
    public String notifyPatientBooking() {

        String result = "";

        try {
            result = notificationService.notifyPatientBooking();
        } catch (Exception e) {
            result = "Error occured notifying patients in the notification service.";
        }

        return result;
    }
}
