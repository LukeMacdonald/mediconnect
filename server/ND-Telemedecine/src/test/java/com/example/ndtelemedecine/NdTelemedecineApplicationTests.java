package com.example.ndtelemedecine;

import com.example.ndtelemedecine.User.User;
import com.example.ndtelemedecine.User.UserRepo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.SerializationFeature;

import static org.mockito.ArgumentMatchers.contains;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.catalina.connector.Response;
import org.hamcrest.Matchers;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.mockito.internal.matchers.Contains;
import org.mockito.internal.matchers.Matches;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.mock.mockito.SpyBean;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

@SpringBootTest
@AutoConfigureMockMvc
class NdTelemedecineApplicationTests {

    @Autowired
    private MockMvc mockMvc;

    @SpyBean
    private APIControllers mockApiController;

    @MockBean
    private UserRepo mockUserRepo;

    List<User> mockUserList = new ArrayList<User>();

    @Test
    // -----------------------------------------------------------------------------------
    // Test: UserRepo should return a list of users (not an error)
    // -----------------------------------------------------------------------------------
    // 1. Call findAll() method
    // 2. Assert whether the request returns OK
    // 3. Assert whether findAll() is a list
    // -----------------------------------------------------------------------------------
    void BackendGetsUsers_True_ReturnsTypeList() throws Exception {

        Mockito.when(mockApiController.getUsers()).thenReturn(Arrays.asList());     // Just needs to return list

        mockMvc.perform(MockMvcRequestBuilders.get("/Users"))
        .andExpect(MockMvcResultMatchers.status().is(200))                                  // Check it does not return error code
        .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON));       // Check it returns a JSON
    }

    // TODO: DON'T DELETE ANY OF BELOW FOR FUTURE REFERENCE
    @Test
    // -----------------------------------------------------------------------------------
    // Test: Add user as doctor
    // -----------------------------------------------------------------------------------
    // 1. Create doctor object
    // 2. Assert add user to database
    // 3. If (2) Passed, mock user will be sent back
    // 4. Assert retrieve user by their email
    // NOTE: There are so many comments but don't delete them for now FOR FUTURE REFERENCE
    // -----------------------------------------------------------------------------------
    void DoctorCreatesAccount_True_DoctorSuccessfullyEnrolled() throws Exception {

        User mockDoctor = new User();

        // "doctor@unittest.com", "password", Role.doctor
        mockDoctor.setEmail("doctor@unittest.com");
        mockDoctor.setPassword("password");
        mockDoctor.setRole("doctor");

        // Object mapper
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(mockDoctor );

        mockMvc.perform(MockMvcRequestBuilders.post("/Register")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk());

        // If passed simulate adding user to mock database and return content-type application/json
        HttpHeaders header = new HttpHeaders();
        header.setContentType(MediaType.APPLICATION_JSON);
        
        // ResponseEntity<List<User>> responseEntity = new ResponseEntity<List<User>>(
        //     header, 
        //     HttpStatus.OK
        // );

        // List<User> response = Arrays.asList(mockDoctor);

        Mockito.when(mockApiController.getUserObjByEmail(mockDoctor)).thenReturn(mockDoctor);

        mockMvc.perform(MockMvcRequestBuilders.get("/GetUserBy/Email")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
        // .andExpect(MockMvcResultMatchers.content().string(contains(substring)))
        .andExpect(MockMvcResultMatchers.jsonPath("$.role", Matchers.is("doctor")));

        // String resultContent = result.getResponse().getContentAsString();
        // System.out.println(resultContent);
        // // .andExpect(MockMvcResultMatchers.jsonPath("$.role", Matchers.is("doctor")));
    }
}

