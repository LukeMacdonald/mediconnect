package com.example.booking_service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

import com.example.booking_service.controller.AppointmentController;
import com.example.booking_service.controller.HealthStatusController;
import com.example.booking_service.controller.NotificationController;
import com.example.booking_service.model.Appointment;
import com.example.booking_service.model.HealthStatus;
import com.example.booking_service.repository.AppointmentRepo;
import com.example.booking_service.repository.HealthStatusRepo;
import com.example.booking_service.repository.UserRepo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.SerializationFeature;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
public class HealthStatusTests {

    @Autowired
    private MockMvc mockMvc;

    @SpyBean
    private HealthStatusController healthStatusController;

    @MockBean
    private HealthStatusRepo healthStatusRepo;

    @MockBean
    private UserRepo userRepo;

    // Setup variables

    private HealthStatus mockhealthStatus;

    @BeforeEach
    public void setup() {
        mockhealthStatus = new HealthStatus();

        mockhealthStatus.setId(1);
        mockhealthStatus.setCoughing(true);
        mockhealthStatus.setHeadaches(true);
        mockhealthStatus.setFainting(false);
        mockhealthStatus.setVomiting(false);
        mockhealthStatus.setFeverOrChills(false);
        mockhealthStatus.setDescription("I woke up with a dry throat and headache");
    }

    @Test
    // -----------------------------------------------------------------------------------
    // Test: Create Health Status
    // -----------------------------------------------------------------------------------
    // 1. Create HealthStatus Objects
    // 2. Mock into database
    // 2. Assert get Health Status
    // 3. Expect not null
    // -----------------------------------------------------------------------------------
    public void createHealthStatus_NotNull_ReturnsHealthStatus() throws Exception {
        setup();

        Mockito.doReturn("Health Status successfully set").when(healthStatusController).saveHealthStatus(mockhealthStatus);

        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();

        String requestJson = ow.writeValueAsString(mockhealthStatus);

        mockMvc.perform(MockMvcRequestBuilders.post("/set/healthstatus")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().string("Health Status successfully set"));
    }

}
