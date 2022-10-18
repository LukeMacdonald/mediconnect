package com.example.medication_service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.aspectj.lang.annotation.Before;
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
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Answers.valueOf;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

import com.example.medication_service.controller.MedicationController;
import com.example.medication_service.model.Disability;
import com.example.medication_service.model.HealthInformation;
import com.example.medication_service.model.Illness;
import com.example.medication_service.model.Medication;
import com.example.medication_service.repository.DisabilityRepo;
import com.example.medication_service.repository.HealthInformationRepo;
import com.example.medication_service.repository.IllnessRepo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.SerializationFeature;


@RunWith(SpringRunner.class)
@SpringBootTest(classes = MedicationServiceApplication.class)
@AutoConfigureMockMvc
public class MedicalHistoryTests {

    @Autowired
    private MockMvc mockMvc;

    @SpyBean
    private MedicationController medicationController;

    @MockBean
    private DisabilityRepo disabilityRepo;

    @MockBean
    private HealthInformationRepo healthInformationRepo;
    
    @MockBean
    private IllnessRepo illnessRepo;

    private Disability mockDisability;
    private HealthInformation mockHealthInformation;
    private Illness mockIllness;
    private Medication mockMedication; 

    ObjectMapper mapper = new ObjectMapper();
    ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
    
    @BeforeEach
    public void setup() {
        mockDisability = new Disability();
        mockHealthInformation = new HealthInformation();
        mockIllness = new Illness();
        mockMedication = new Medication();

        mockDisability.setId(1);
        mockDisability.setUserId(1);
        mockDisability.setDisability("Autism");

        mockHealthInformation.setId(1);
        mockHealthInformation.setSmoke(false);
        mockHealthInformation.setSmoke(true);
        mockHealthInformation.setSmoke(true);

        mockIllness.setId(1);
        mockIllness.setUserId(1);
        mockIllness.setIllness("Cancer");

        mockMedication.setId(1);
        mockMedication.setUserId(1);
        mockMedication.setName("Panadol");
        mockMedication.setDosage(1000.0);
        mockMedication.setRepeat(2);

    }

    @Test
    // -----------------------------------------------------------------------------------
    // Test: Get Disability
    // -----------------------------------------------------------------------------------
    // 1. Create Medical History Objects
    // 2. Mock into database
    // 2. Assert get Medical History
    // 3. Expect not null
    // -----------------------------------------------------------------------------------
    public void getDisability_NotNull_ReturnsDisability() throws Exception {
        setup();
        
        List<Disability> disabilityList = new ArrayList<>();

        disabilityList.add(mockDisability);

        String expectedResponse = ow.writeValueAsString(disabilityList);


        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();

        ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(expectedResponse);
        Mockito.doReturn(responseEntity).when(medicationController).getDisabilities(1);

        mockMvc.perform(MockMvcRequestBuilders.get("/get/disabilities/{userId}", mockDisability.getUserId())
        .contentType(MediaType.APPLICATION_JSON))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
        .andExpect(jsonPath("$[0].id", Matchers.is(mockDisability.getId())));
    }

    @Test
    // -----------------------------------------------------------------------------------
    // Test: Get Health Information
    // -----------------------------------------------------------------------------------
    // 1. Create Medical History Objects
    // 2. Mock into database
    // 2. Assert get Medical History
    // 3. Expect not null
    // -----------------------------------------------------------------------------------
    public void getHealthInformation_NotNull_ReturnsHealthInformation() throws Exception {
        setup();

        Mockito.doReturn(new ResponseEntity(mockHealthInformation, HttpStatus.OK)).when(medicationController).setHealthInformation(mockHealthInformation);

        String expectedResponse = ow.writeValueAsString(mockHealthInformation);

        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();

        ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(expectedResponse);
        Mockito.doReturn(responseEntity).when(medicationController).getHealthInformation(1);

        mockMvc.perform(MockMvcRequestBuilders.get("/get/healthinformation/{userId}", mockHealthInformation.getId())
        .contentType(MediaType.APPLICATION_JSON))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
        .andExpect(jsonPath("$.id", Matchers.is(mockHealthInformation.getId())));
    }

    @Test
    // -----------------------------------------------------------------------------------
    // Test: Get Illnesses
    // -----------------------------------------------------------------------------------
    // 1. Create Medical History Objects
    // 2. Mock into database
    // 2. Assert get Medical History
    // 3. Expect not null
    // -----------------------------------------------------------------------------------
    public void getIllness_NotNull_ReturnsIllness() throws Exception {
        setup();
        
        List<Illness> illnessList = new ArrayList<>();

        illnessList.add(mockIllness);

        String expectedResponse = ow.writeValueAsString(illnessList);

        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();

        ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(expectedResponse);
        Mockito.doReturn(responseEntity).when(medicationController).getIllnesses(1);

        mockMvc.perform(MockMvcRequestBuilders.get("/get/illnesses/{userId}", mockIllness.getUserId())
        .contentType(MediaType.APPLICATION_JSON))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
        .andExpect(jsonPath("$[0].id", Matchers.is(mockIllness.getId())));
    }

    @Test
    // -----------------------------------------------------------------------------------
    // Test: Get Illnesses
    // -----------------------------------------------------------------------------------
    // 1. Create Medical History Objects
    // 2. Mock into database
    // 2. Assert get Medical History
    // 3. Expect not null
    // -----------------------------------------------------------------------------------
    public void getMedication_NotNull_ReturnsMedication() throws Exception {
        setup();
        
        List<Medication> medicationList = new ArrayList<>();

        medicationList.add(mockMedication);

        String expectedResponse = ow.writeValueAsString(medicationList);

        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();

        ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(expectedResponse);
        Mockito.doReturn(responseEntity).when(medicationController).getMedications(1);

        mockMvc.perform(MockMvcRequestBuilders.get("/get/medications/{userId}", mockMedication.getUserId())
        .contentType(MediaType.APPLICATION_JSON))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
        .andExpect(jsonPath("$[0].id", Matchers.is(mockMedication.getId())));
    }

}
