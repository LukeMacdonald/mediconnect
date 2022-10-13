package com.example.prescription_service.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.prescription_service.model.Prescription;
import com.example.prescription_service.repository.PrescriptionRepo;
import com.example.prescription_service.repository.UserRepo;

import lombok.NoArgsConstructor;

@Component
@NoArgsConstructor
public class PrescriptionAlertService {

    @Autowired
    private PrescriptionRepo prescriptionRepo;
    
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private JavaMailSender javaMailSender;

    @Value("${spring.mail.username}") private String sender;

    @Scheduled(cron = "0 0 * * * *")
    public String remindPrescriptions() {

        List<Prescription> upcomingPrescriptions = getAllPrescription();

        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(sender);

        for (int i = 0; i < upcomingPrescriptions.size(); i++) {

            alertSinglePatient(upcomingPrescriptions.get(i));
        }

        return "patients have been notified about their ongoing prescriptions.";
    }

    public List<Prescription> getAllPrescription() {
        return prescriptionRepo.findAll();
    }

    public void alertSinglePatient(Prescription prescription) {
        Prescription currentPrescription = prescription;

        // Setup email details
        String userEmail = "";
        try {
            userEmail = userRepo.findUserById(currentPrescription.getPatientID()).getEmail();
        } catch (Exception e) {
            // This should never occur in the first place, but as a safety measure anyway:
            System.out.println("User with ID: " + currentPrescription.getPatientID() + " could not be found. Skipping...");
            return;
        }

        String emailSubj = "Reminder: You have a prescription to take today!";
        String emailBody = "This email is a reminder that you have an prescription to take today.\n"
                            + "Prescription Details:\n"
                            + "\tPrescription Name: " + currentPrescription.getName() + "\n"
                            + "\tPrescription Dosage: " + currentPrescription.getDosage() + "\n"
                            + "\tPrescription Repeats: " + currentPrescription.getRepeats() + "\n"
                            ;

        // Send email
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(sender);

        mailMessage.setTo(userEmail);
        mailMessage.setSubject(emailSubj);
        mailMessage.setText(emailBody);
        javaMailSender.send(mailMessage);

        System.out.println("Mail sent to " + currentPrescription.getPatientID());
    }
}
