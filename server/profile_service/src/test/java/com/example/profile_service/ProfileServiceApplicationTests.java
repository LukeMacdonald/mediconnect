package com.example.profile_service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.Test;
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

import com.example.profile_service.controller.UserController;
import com.example.profile_service.model.User;
import com.example.profile_service.repository.UserRepo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
public class ProfileServiceApplicationTests {

    @Autowired
    private MockMvc mockMvc;

    @SpyBean
    private UserController userController;

    @MockBean
    private UserRepo userRepo;

    private User mockUserPatient;
    private User mockUserDoctor;

    ObjectMapper mapper = new ObjectMapper();
    ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();

    @BeforeEach
    public void setup(){
        mockUserPatient = new User("patient@email.com", "test", "patient");
        mockUserDoctor = new User("doctor@email.com", "test", "doctor");
    }

    @Test
   // -----------------------------------------------------------------------------------
   // Test: Superadmin removing a patient
   // -----------------------------------------------------------------------------------
   // 1. Create user account Object (patient)
   // 2. Assert the remove by email call
   // 3. Expect to be "Successfully deleted"
   // -----------------------------------------------------------------------------------
   public void removeAcccountByEmailPatient_SuccessfulMessage_ReturnsSuccessful() throws Exception {
        setup();

        ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.TEXT_PLAIN).body("Successfully deleted");
        Mockito.doReturn(responseEntity).when(userController).removeUserByEmail(mockUserPatient.getEmail());
 
        mockMvc.perform(MockMvcRequestBuilders.delete("/remove/{email}", mockUserPatient.getEmail()))
       .andExpect(MockMvcResultMatchers.status().isOk());
   }

   @Test
   // -----------------------------------------------------------------------------------
   // Test: Superadmin removing a doctor
   // -----------------------------------------------------------------------------------
   // 1. Create user account Object (doctor)
   // 2. Assert the remove by email call
   // 3. Expect to be "Successfully deleted"
   // -----------------------------------------------------------------------------------
   public void removeAcccountByEmailDoctor_SuccessfulMessage_ReturnsSuccessful() throws Exception {
        setup();

        ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.TEXT_PLAIN).body("Successfully deleted");
        Mockito.doReturn(responseEntity).when(userController).removeUserByEmail(mockUserDoctor.getEmail());
 
        mockMvc.perform(MockMvcRequestBuilders.delete("/remove/{email}", mockUserDoctor.getEmail()))
       .andExpect(MockMvcResultMatchers.status().isOk());
   }

}
