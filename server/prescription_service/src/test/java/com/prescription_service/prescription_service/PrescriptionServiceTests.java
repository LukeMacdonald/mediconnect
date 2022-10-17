package com.prescription_service.prescription_service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

import com.example.prescription_service.*;
import com.example.prescription_service.controller.PrescriptionController;
import com.example.prescription_service.model.Prescription;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;
import com.fasterxml.jackson.datatype.jsr310.*;
import com.fasterxml.jackson.module.paramnames.ParameterNamesModule;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = PrescriptionServiceApplication.class)
@AutoConfigureMockMvc
public class PrescriptionServiceTests {

    @Autowired
    private MockMvc mockMvc;

    @SpyBean
    private PrescriptionController prescriptionController;

    private Prescription prescription1;
    private Prescription prescription2;
    private Prescription prescription3;

    ObjectMapper mapper = new ObjectMapper()
        .registerModule(new ParameterNamesModule())
        .registerModule(new Jdk8Module())
        .registerModule(new JavaTimeModule());
    ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();

    @BeforeEach
    public void setup() {
        prescription1 = new Prescription();
        prescription2 = new Prescription();
        prescription3 = new Prescription();

        // patient ID
        prescription1.setPatientID(1);
        prescription2.setPatientID(2);
        prescription3.setPatientID(3);

        // doctor ID
        prescription1.setDoctorID(1);
        prescription2.setDoctorID(2);
        prescription3.setDoctorID(3);

        // name
        prescription1.setName("COVID-solver");
        prescription2.setName("CANCER-curer");
        prescription3.setName("PANADOL");

        // dosage
        prescription1.setDosage(2.5);
        prescription2.setDosage(1.0);
        prescription3.setDosage(3.6);

        // repeats
        prescription1.setRepeats(2);
        prescription2.setRepeats(2);
        prescription3.setRepeats(3);

        // prescriptionID
        prescription1.setprescriptionID(1);
        prescription2.setprescriptionID(2);
        prescription3.setprescriptionID(3);
    }

   @Test
   public void PostPrescription_Saved_PrescriptionSavedSuccessfully() throws Exception {
       setup();

       String expectedResponse = ow.writeValueAsString(prescription1);

       ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(expectedResponse);

       Mockito.doReturn(responseEntity).when(prescriptionController).prescribePatient(prescription1);

       mockMvc.perform(
           MockMvcRequestBuilders.post("/prescribe")
           .contentType(MediaType.APPLICATION_JSON)
           .content(expectedResponse))
           .andExpect(MockMvcResultMatchers.status().isOk())
           .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
           .andExpect(jsonPath("$.name", Matchers.is(prescription1.getName()))
       );
   }

   @Test
   public void notifyPrescriptions_NoErrorThrown_AllPatientsNotified() throws Exception {
        setup();
        Mockito.doReturn("patients have been notified about their ongoing prescriptions.").when(prescriptionController).alertPrescriptions();

        mockMvc.perform(
           MockMvcRequestBuilders.get("/alert/prescription"))
           .andExpect(MockMvcResultMatchers.status().isOk()
       );
   }

   
}
