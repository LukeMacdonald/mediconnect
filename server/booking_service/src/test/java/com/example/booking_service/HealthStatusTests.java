package com.example.booking_service;

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

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

import com.example.booking_service.controller.HealthStatusController;
import com.example.booking_service.model.HealthStatus;
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
        mockhealthStatus.setFeverOrChills(false);
        mockhealthStatus.setCoughing(true);
        mockhealthStatus.setHeadaches(true);
        mockhealthStatus.setFainting(false);
        mockhealthStatus.setVomiting(false);
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

    @Test
    // -----------------------------------------------------------------------------------
    // Test: Getting health status
    // -----------------------------------------------------------------------------------
    // 1. Create Health Status Objects
    // 2. Mock into database
    // 2. Assert get health status
    // 3. Expect returned health status
    // -----------------------------------------------------------------------------------
    public void getHealthStatus_NotEmpty_ReturnsHealthStatus() throws Exception {
        setup();

        Mockito.doReturn("Health Status successfully set").when(healthStatusController).saveHealthStatus(mockhealthStatus);
        Mockito.doReturn(mockhealthStatus).when(healthStatusController).getHealthStatus(mockhealthStatus.getId());

        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();

        String requestJson = ow.writeValueAsString(mockhealthStatus.getId());

        mockMvc.perform(MockMvcRequestBuilders.get("/search/healthstatus/{id}", mockhealthStatus.getId())
        .contentType(MediaType.APPLICATION_JSON))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
        .andExpect(jsonPath("$.id", Matchers.is(mockhealthStatus.getId())));
    }
    
    @Test
    // -----------------------------------------------------------------------------------
    // Test: Updating health status
    // -----------------------------------------------------------------------------------
    // 1. Create Health Status Objects
    // 2. Mock into database
    // 2. Assert update health status
    // 3. Expect returned health status
    // -----------------------------------------------------------------------------------
    public void updateHealthStatus_NotNull_ReturnsUpdatedHealthStatus() throws Exception {
        setup();

        Mockito.doReturn("Health Status successfully set").when(healthStatusController).saveHealthStatus(mockhealthStatus);


        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String expectedResponse = ow.writeValueAsString(mockhealthStatus);

        Mockito.doReturn(mockhealthStatus).when(healthStatusRepo).findHealthStatusById(mockhealthStatus.getId());

        mockhealthStatus.setDescription("I woke up feeling dizzy and tired");

        expectedResponse = ow.writeValueAsString(mockhealthStatus);

        mockMvc.perform(MockMvcRequestBuilders.put("/update/healthstatus").contentType(MediaType.APPLICATION_JSON)
                .contentType(MediaType.APPLICATION_JSON).content(expectedResponse))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.description", Matchers.is("I woke up feeling dizzy and tired")));
    } 

}
