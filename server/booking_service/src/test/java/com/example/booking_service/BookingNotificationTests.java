package com.example.booking_service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.hamcrest.Matchers;
import org.junit.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.mock.mockito.SpyBean;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Answers.valueOf;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

import com.example.booking_service.controller.AppointmentController;
import com.example.booking_service.controller.NotificationController;
import com.example.booking_service.model.Appointment;
import com.example.booking_service.repository.AppointmentRepo;
import com.example.booking_service.repository.UserRepo;
import com.example.booking_service.service.NotificationService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
public class BookingNotificationTests {

    @Autowired
    private MockMvc mockMvc;

    @SpyBean
    private NotificationController notificationController;

    @SpyBean
    private AppointmentController appointmentController;

    @MockBean
    private AppointmentRepo appointmentRepo;

    @MockBean
    private UserRepo userRepo;

    // Setup variables

    private Appointment mockAppointment1;
    private Appointment mockAppointment2;
    private Appointment mockAppointment3;

    long milis = System.currentTimeMillis();
    Date currentDate = new Date(milis);
    // LocalDateTime ldt = LocalDateTime.ofInstant(in.toInstant(),
    // ZoneId.systemDefault());
    // Date currentDate = (Date)
    // Date.from(ldt.atZone(ZoneId.systemDefault()).toInstant());

    ObjectMapper mapper = new ObjectMapper();
    ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();

    @BeforeEach
    public void setup() {
        mockAppointment1 = new Appointment();
        mockAppointment2 = new Appointment();
        mockAppointment3 = new Appointment();

        // ID
        mockAppointment1.setId(1);
        mockAppointment2.setId(2);
        mockAppointment3.setId(3);

        // Date
        mockAppointment1.setDate(currentDate);
        mockAppointment2.setDate(currentDate);
        mockAppointment3.setDate(currentDate);

        // PatientID
        mockAppointment1.setPatient(1);
        mockAppointment2.setPatient(2);
        mockAppointment3.setPatient(3);

        // DoctorID
        mockAppointment1.setDoctorId(1);
        mockAppointment2.setDoctorId(2);
        mockAppointment3.setDoctorId(3);

        // Time
        mockAppointment1.setTime("00:00:00");
        mockAppointment2.setTime("00:00:00");
        mockAppointment3.setTime("00:00:00");

        // Today
        mockAppointment1.setToday("00:00:00");
        mockAppointment2.setToday("00:00:00");
        mockAppointment3.setToday("00:00:00");
    }

   @Test
   // -----------------------------------------------------------------------------------
   // Test: Get Upcoming Appointments
   // -----------------------------------------------------------------------------------
   // 1. Create Appointment Objects
   // 2. Mock into database
   // 2. Assert get upcoming appointments
   // 3. Expect not empty
   // -----------------------------------------------------------------------------------
   public void getUpcomingAppointments_NotEmpty_ReturnsNonEmptyList() throws Exception {
       setup();
       List<Appointment> appointmentList = new ArrayList<>();
       appointmentList.add(mockAppointment1);
       appointmentList.add(mockAppointment2);
       appointmentList.add(mockAppointment3);

       String expectedResponse = ow.writeValueAsString(appointmentList);

       ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(expectedResponse);
       Mockito.doReturn(responseEntity).when(notificationController).getUpcomingAppointments();

       mockMvc.perform(MockMvcRequestBuilders.get("/search/appointment/date"))
       .andExpect(MockMvcResultMatchers.status().isOk())
       .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
       .andExpect(jsonPath("$.[0].id", Matchers.is(1)))
       .andExpect(jsonPath("$.[1].id", Matchers.is(2)))
       .andExpect(jsonPath("$.[2].id", Matchers.is(3)));
   }

   @Test
   // -----------------------------------------------------------------------------------
   // Test: Upcoming Appointments should be empty
   // -----------------------------------------------------------------------------------
   // 1. Create Appointment Objects
   // 2. Mock into database
   // 2. Assert get upcoming appointments
   // 3. Expect empty
   // -----------------------------------------------------------------------------------
   public void getUpcomingAppointments_Empty_ReturnsEmptyList() throws Exception {
       setup();

       Date newDate = Date.valueOf("2015-03-30");

       List<Appointment> appointmentList = new ArrayList<>();

       mockAppointment1.setDate(newDate);
       mockAppointment2.setDate(newDate);
       mockAppointment3.setDate(newDate);

       appointmentList.add(mockAppointment1);
       appointmentList.add(mockAppointment2);
       appointmentList.add(mockAppointment3);

       Mockito.doReturn(null).when(notificationController).getUpcomingAppointments();

       mockMvc.perform(MockMvcRequestBuilders.get("/search/appointment/date"))
       .andExpect(MockMvcResultMatchers.status().isOk())
       .andExpect(jsonPath("$").doesNotExist());
   }

   @Test
   // -----------------------------------------------------------------------------------
   // Test: Notify users should not throw error
   // -----------------------------------------------------------------------------------
   // 1. Create Appointment Objects
   // 2. Mock into database
   // 2. Perform notifyPatientBooking()
   // 3. Expect no error thrown
   // -----------------------------------------------------------------------------------
   public void notifyUsers_ErrorNotThrown_SuccessfullyNotifiedUsers() throws Exception {
       setup();

       List<Appointment> appointmentList = new ArrayList<>();
       appointmentList.add(mockAppointment1);
       appointmentList.add(mockAppointment2);
       appointmentList.add(mockAppointment3);

       String expectedResponse = ow.writeValueAsString(appointmentList);

       ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(expectedResponse);

       Mockito.doReturn(responseEntity).when(notificationController).getUpcomingAppointments();

       assertDoesNotThrow(() -> notificationController.notifyPatientBooking());
   }


    // /delete/appointment/{id}"
    @Test
    public void cancelAppointment_ErrorNotThrown_SuccessfullyRemovedAppointment() throws Exception {
        setup();

       String expectedResponse = ow.writeValueAsString(mockAppointment1);

       ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(expectedResponse);

       Mockito.doNothing().when(appointmentController).deleteAppointment(mockAppointment1.getId());

       int id = 0;
       mockMvc.perform(MockMvcRequestBuilders.delete("/delete/appointment/{id}", id))
       .andExpect(MockMvcResultMatchers.status().isOk())
       .andExpect(jsonPath("$").doesNotExist());
    }
}
