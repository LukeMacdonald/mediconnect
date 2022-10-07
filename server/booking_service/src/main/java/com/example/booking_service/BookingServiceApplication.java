package com.example.booking_service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.booking_service.service.NotificationService;

@SpringBootApplication
public class BookingServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(BookingServiceApplication.class, args);
    }

    // Push Appointment Notifications every X
//    @Component
//    public class JobScheduler {
//
//        @Autowired
//        private NotificationService notifService;
//
//        @Async
//        @Scheduled(cron = "0 0 * * * *")    // Asterisks indicate that next task scheduled will be on the next day at midnight
//        void someJob() {
//            System.out.println("Starting async cron job...");
//            notifService.notifyPatientBooking();
//            System.out.println("Cron job finished.");
//        }
//    }
}

//@Configuration
//@EnableScheduling
//@ConditionalOnProperty(name = "scheduling.enabled", matchIfMissing = true)
//class SchedulingConfiguration {}