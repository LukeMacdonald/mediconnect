package com.example.ndtelemedecine;

import com.example.ndtelemedecine.Controllers.UserApiController;
import com.example.ndtelemedecine.Controllers.AvailabilityApiController;
import com.example.ndtelemedecine.Models.User;
import com.example.ndtelemedecine.Models.Availability;

import com.example.ndtelemedecine.Repositories.AvailabilityRepo;
import com.example.ndtelemedecine.Repositories.UserRepo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.SerializationFeature;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.mock.mockito.SpyBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

@SpringBootTest
@AutoConfigureMockMvc
public class DoctorAvailabilityTest {

    @Autowired
    private MockMvc mockMvc;

    @SpyBean
    private UserApiController mockUserApiController;

    @SpyBean
    private AvailabilityApiController mockApiController;

    @MockBean
    private static UserRepo mockUserRepo;

    @MockBean
    private AvailabilityRepo mostAvailabilityRepo;

    @Autowired
    ObjectMapper mapper;

    private static User mockDoctor;

    private Availability avail;

    @BeforeAll
    static void setDoctor(){
        mockDoctor = new User();
        mockDoctor.setEmail("doctor@unittest.com");
        mockDoctor.setPassword("password");
        mockDoctor.setRole("doctor"); 
    }
    @BeforeEach
    void mockData(){
        Mockito.when(mockUserRepo.findById(0)).thenReturn(mockDoctor);
        avail = new Availability();
        avail.setDoctorId(mockDoctor.getID());
    }
    @Test
        // -----------------------------------------------------------------------------------
        // Test: Availability API Controller should return a message confirming success
        // -----------------------------------------------------------------------------------
        // 1. Set Variables of availability
        // 2. Assert whether the request returns OK
        // 3. Assert whether the availability is successfully set
        // -----------------------------------------------------------------------------------
    void setDoctorAvailability_ReturnsTrue() throws Exception{
        
        avail.setStartTime("12:00");
        avail.setEndTime(":13:00");
        avail.setDayOfWeek(1);
    
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(avail);

        mockMvc.perform(MockMvcRequestBuilders.post("/doctor/SetDoctorAvailability")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().string("Availability Set!"));
    }

    @Test
        // -----------------------------------------------------------------------------------
        // Test: Availability API Controller should return a message indicating day_of_week
        //       Value is to High (Tests the value just past the upper boundary value)
        // -----------------------------------------------------------------------------------
        // 1. Set Variables of availability
        // 2. Assert whether the request returns OK
        // 3. Assert whether the availability is successfully set (returns unsuccessful message)
        // -----------------------------------------------------------------------------------
    void setDoctorAvailability_BoundryHighFalse() throws Exception{

        avail.setStartTime("09:00:00");
        avail.setEndTime("10:00:00");
        avail.setDayOfWeek(7);

        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(avail);

        mockMvc.perform(MockMvcRequestBuilders.post("/doctor/SetDoctorAvailability")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().string("Incorrect Entry: Day of Week Entered was To High"));
    }
    @Test
        // -----------------------------------------------------------------------------------
        // Test: Availability API Controller should return a message confirming success
        //       (Tests the upper boundary value)
        // -----------------------------------------------------------------------------------
        // 1. Set Variables of availability
        // 2. Assert whether the request returns OK
        // 3. Assert whether the availability is successfully set (returns successful message)
        // -----------------------------------------------------------------------------------
    void setDoctorAvailability_BoundryHighReturnsTrue() throws Exception{
        
        avail.setStartTime("09:00:00");
        avail.setEndTime("10:00:00");
        avail.setDayOfWeek(6);

        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(avail);

        mockMvc.perform(MockMvcRequestBuilders.post("/doctor/SetDoctorAvailability")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().string("Availability Set!"));
    }
    @Test
        // -----------------------------------------------------------------------------------
        // Test: Availability API Controller should return a message indicating day_of_week
        //       Value is too Low (Tests the value just past the lower boundary value)
        // -----------------------------------------------------------------------------------
        // 1. Set Variables of availability
        // 2. Assert whether the request returns OK
        // 3. Assert whether the availability is successfully set (returns unsuccessful message)
        // -----------------------------------------------------------------------------------
    void setDoctorAvailability_BoundryLowFalse() throws Exception{

        avail.setStartTime("09:00:00");
        avail.setEndTime("10:00:00");
        avail.setDayOfWeek(0);

        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(avail);

        mockMvc.perform(MockMvcRequestBuilders.post("/doctor/SetDoctorAvailability")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().string("Incorrect Entry: Day of Week Entered was To Low"));
    }
    @Test
        // -----------------------------------------------------------------------------------
        // Test: Availability API Controller should return a message confirming success
        //       (Tests the lower boundary value)
        // -----------------------------------------------------------------------------------
        // 1. Set Variables of availability
        // 2. Assert whether the request returns OK
        // 3. Assert whether the availability is successfully set (returns successful message)
        // -----------------------------------------------------------------------------------
    void setDoctorAvailability_BoundryLowReturnsTrue() throws Exception{

        avail.setStartTime("09:00:00");
        avail.setEndTime("10:00:00");
        avail.setDayOfWeek(1);
    
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(avail);

        mockMvc.perform(MockMvcRequestBuilders.post("/doctor/SetDoctorAvailability")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().string("Availability Set!"));
    }
}

