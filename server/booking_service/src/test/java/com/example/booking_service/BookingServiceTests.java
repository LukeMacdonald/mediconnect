package com.example.booking_service;

import org.hamcrest.Matchers;
import org.junit.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.SpyBean;
import org.springframework.data.jpa.convert.threeten.Jsr310JpaConverters;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import com.example.booking_service.controller.AppointmentController;
import com.example.booking_service.model.Appointment;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;
import com.fasterxml.jackson.datatype.jsr310.*;
import com.fasterxml.jackson.module.paramnames.ParameterNamesModule;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

import java.sql.Date;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = BookingServiceApplication.class)
@AutoConfigureMockMvc
public class BookingServiceTests {

    @Autowired
    private MockMvc mockMvc;

    @SpyBean
    private AppointmentController appointmentController;

    private Appointment appointment1;
    private Appointment appointment2;
    private Appointment appointment3;

    ObjectMapper mapper = new ObjectMapper()
            .registerModule(new ParameterNamesModule())
            .registerModule(new Jdk8Module())
            .registerModule(new JavaTimeModule());
    ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();

    @BeforeEach
    public void setup() {
        appointment1 = new Appointment();
        appointment2 = new Appointment();
        appointment3 = new Appointment();

        // patient ID
        appointment1.setPatient(1);
        appointment2.setPatient(2);
        appointment3.setPatient(3);

        // doctor ID
        appointment1.setDoctorId(1);
        appointment2.setDoctorId(2);
        appointment3.setDoctorId(3);

        // time
        appointment1.setTime("12:00:00");
        appointment2.setTime("8:00:00");
        appointment3.setTime("23:00:00");

        // date
        long milis = System.currentTimeMillis();
        Date currentDate = new Date(milis);
        appointment1.setDate(currentDate);
        appointment2.setDate(currentDate);
        appointment3.setDate(currentDate);

        // today
        appointment1.setToday("0:00:00");
        appointment2.setToday("0:00:00");
        appointment3.setToday("0:00:00");
    }

    @Test
    public void bookAppointment_NoErrorThrown_AppointmentSuccessfullyPosted() throws Exception {
       setup();

       String expectedResponse = ow.writeValueAsString(appointment1);

       ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(appointment1.getId());

       Mockito.doReturn(responseEntity).when(appointmentController).saveAppointment(appointment1);

       mockMvc.perform(MockMvcRequestBuilders.post("/set/appointment")
       .contentType(MediaType.APPLICATION_JSON)
       .content(expectedResponse))
       .andExpect(MockMvcResultMatchers.status().isOk());
    }

    @Test
    public void rescheduleAppointment_NoErrorThrown_AppointmentSuccessfullyRescheduled() throws Exception {
       setup();

       String expectedResponse = ow.writeValueAsString(appointment1);

       ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(appointment1.getId());

       Mockito.doReturn(responseEntity).when(appointmentController).saveAppointment(appointment1);

       mockMvc.perform(MockMvcRequestBuilders.post("/set/appointment")
       .contentType(MediaType.APPLICATION_JSON)
       .content(expectedResponse))
       .andExpect(MockMvcResultMatchers.status().isOk());
    }
}
