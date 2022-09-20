package com.example.ndtelemedecine;

import com.example.ndtelemedecine.Controllers.AppointmentApiController;
import com.example.ndtelemedecine.Controllers.AuthenticationApiController;
import com.example.ndtelemedecine.Controllers.AvailabilityApiController;
import com.example.ndtelemedecine.Controllers.UserApiController;
import com.example.ndtelemedecine.Models.Appointment;
import com.example.ndtelemedecine.Repositories.AppointmentRepo;
import com.example.ndtelemedecine.Models.User;
import com.example.ndtelemedecine.Repositories.UserRepo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.SerializationFeature;

import static org.mockito.ArgumentMatchers.contains;

import java.sql.Date;
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
class UserTests {

    @Autowired
    private MockMvc mockMvc;

    @SpyBean
    private AppointmentApiController mockAppointmentApiController;

    @SpyBean
    private AuthenticationApiController mockAuthenticationApiController;

    @SpyBean
    private AvailabilityApiController mockAvailabilityApiController;

    @SpyBean
    private UserApiController mockUserApiController;


    @MockBean
    private UserRepo mockUserRepo;

    @MockBean
    private AppointmentRepo mockAppointmentRepo;

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

        Mockito.when(mockUserApiController.getUsers()).thenReturn(Arrays.asList());     // Just needs to return list

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

        Mockito.when(mockUserApiController.getUserObjByEmail(mockDoctor)).thenReturn(mockDoctor);

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

    @Test
    // -----------------------------------------------------------------------------------
    // Test: Add user as patient
    // -----------------------------------------------------------------------------------
    // 1. Create patient object
    // 2. Assert add user to database
    // 3. If (2) Passed, mock user will be sent back
    // 4. Assert retrieve user by their email
    // NOTE: There are so many comments but don't delete them for now FOR FUTURE REFERENCE
    // -----------------------------------------------------------------------------------
    void PateintCreatesAccount_True_PatientSuccessfullyEnrolled() throws Exception {

        User mockPatient = new User();

        // "doctor@unittest.com", "password", Role.doctor
        mockPatient.setEmail("patient@unittest.com");
        mockPatient.setPassword("password");
        mockPatient.setRole("patient");

        // Object mapper
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(mockPatient);

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

        Mockito.when(mockUserApiController.getUserObjByEmail(mockPatient)).thenReturn(mockPatient);

        mockMvc.perform(MockMvcRequestBuilders.get("/GetUserBy/Email")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
        // .andExpect(MockMvcResultMatchers.content().string(contains(substring)))
        .andExpect(MockMvcResultMatchers.jsonPath("$.role", Matchers.is("patient")));

        // String resultContent = result.getResponse().getContentAsString();
        // System.out.println(resultContent);
        // // .andExpect(MockMvcResultMatchers.jsonPath("$.role", Matchers.is("doctor")));
    }

    @Test
    // -----------------------------------------------------------------------------------
    // Test: Update patients profile 
    // -----------------------------------------------------------------------------------
    // 1. Create patient object
    // 2. Assert add user to database
    // 3. If (2) Passed, mock user will be sent back
    // 4. Assert retrieve user by their email
    // NOTE: There are so many comments but don't delete them for now FOR FUTURE REFERENCE
    // -----------------------------------------------------------------------------------
    void PatientCreatesProfile_True_PatientSuccessfullyCreatedProfile() throws Exception {

        User mockPatient = new User();

        // "patient@unittest.com", "password", Role.patient
        mockPatient.setEmail("patient@unittest.com");
        mockPatient.setPassword("password");
        mockPatient.setRole("patient");
        mockPatient.setFirstName("Jamal");
        mockPatient.setLastName("Jamalson");
        Date dob = new Date(1996/11/11);
        mockPatient.setDob(dob);
        mockPatient.setPhoneNumber("123456789");

        // Object mapper
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(mockPatient);

        mockMvc.perform(MockMvcRequestBuilders.post("/Register")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk());

        Mockito.when(mockUserApiController.getUserObjByEmail(mockPatient)).thenReturn(mockPatient);
        Mockito.when(mockUserRepo.findByEmail(Mockito.anyString())).thenReturn(Arrays.asList(mockPatient));

        mockMvc.perform(MockMvcRequestBuilders.put("/UpdateUser")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk());

        // If passed simulate adding user to mock database and return content-type application/json
        HttpHeaders header = new HttpHeaders();
        header.setContentType(MediaType.APPLICATION_JSON);
        
        Mockito.when(mockUserApiController.getUserObjByEmail(mockPatient)).thenReturn(mockPatient);

        mockMvc.perform(MockMvcRequestBuilders.get("/GetUserBy/Email")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
        .andExpect(MockMvcResultMatchers.jsonPath("$.role", Matchers.is("patient")))
        .andExpect(MockMvcResultMatchers.jsonPath("$.firstName", Matchers.is("Jamal")))
        .andExpect(MockMvcResultMatchers.jsonPath("$.lastName", Matchers.is("Jamalson")))
        .andExpect(MockMvcResultMatchers.jsonPath("$.dob", Matchers.is("1970-01-01")))
        .andExpect(MockMvcResultMatchers.jsonPath("$.phoneNumber", Matchers.is("123456789")));
    }

    @Test
    // -----------------------------------------------------------------------------------
    // Test: Log into patient account 
    // -----------------------------------------------------------------------------------
    // 1. Create patient object
    // 2. Assert add user to database
    // 3. If (2) Passed, mock user will be sent back
    // 4. Assert retrieve user by their email
    // NOTE: There are so many comments but don't delete them for now FOR FUTURE REFERENCE
    // -----------------------------------------------------------------------------------
    void PateintLogsIn_True_PatientSuccessfullyLoggedIn() throws Exception {

        User mockPatient = new User();

        // "doctor@unittest.com", "password", Role.doctor
        mockPatient.setEmail("patient@unittest.com");
        mockPatient.setPassword("passwordUnitTest");
        mockPatient.setRole("patient");

        // Object mapper
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(mockPatient);

        // First register a patient mock object that will be used to login
        mockMvc.perform(MockMvcRequestBuilders.post("/Register")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk());

        Mockito.when(mockUserApiController.getUserObjByEmail(mockPatient)).thenReturn(mockPatient);
        Mockito.when(mockUserRepo.findByEmail(Mockito.anyString())).thenReturn(Arrays.asList(mockPatient));

        mockMvc.perform(MockMvcRequestBuilders.post("/LogInAttempt")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk());

        // If passed simulate adding user to mock database and return content-type application/json
        HttpHeaders header = new HttpHeaders();
        header.setContentType(MediaType.APPLICATION_JSON);

        Mockito.when(mockUserApiController.getUserObjByEmail(mockPatient)).thenReturn(mockPatient);

        // mockMvc.perform(MockMvcRequestBuilders.get("/LogIn/{email}", mockPatient.getEmail())
        // .contentType(MediaType.APPLICATION_JSON)
        // .content(requestJson))
        // .andExpect(MockMvcResultMatchers.status().isOk())
        // .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
        // .andExpect(MockMvcResultMatchers.jsonPath("$.email", Matchers.is("patient@unittest.com")))
        // .andExpect(MockMvcResultMatchers.jsonPath("$.password", Matchers.is("passwordUnitTest")))
        // .andExpect(MockMvcResultMatchers.jsonPath("$.role", Matchers.is("patient")));

        mockMvc.perform(MockMvcRequestBuilders.get("/LogIn/{email}", mockPatient.getEmail()))
        .andExpect(MockMvcResultMatchers.status().isOk());
    }

    @Test
    // -----------------------------------------------------------------------------------
    // Test: Patient books an appointment
    // -----------------------------------------------------------------------------------
    // 1. Create patient and doctor object
    // 2. Assert add users to database
    // 3. If (2) Passed, mock user will be sent back
    // 4. Assert retrieve user by their email
    // NOTE: There are so many comments but don't delete them for now FOR FUTURE REFERENCE
    // -----------------------------------------------------------------------------------
    void PatientBooksAppointment_True_PatientSuccessfullyBooked() throws Exception {

        User mockPatient = new User();

        // "patient@unittest.com", "password", Role.patient
        mockPatient.setEmail("patient@unittest.com");
        mockPatient.setPassword("password");
        mockPatient.setRole("patient");
        mockPatient.setFirstName("Jamal");
        mockPatient.setLastName("Jamalson");
        Date dob = new Date(1996/11/11);
        mockPatient.setDob(dob);
        mockPatient.setPhoneNumber("123456789");

        User mockDoctor = new User();

        mockDoctor.setEmail("doctor@unittest.com");
        mockDoctor.setPassword("password");
        mockDoctor.setRole("doctor");
        mockDoctor.setFirstName("Mikeal");
        mockDoctor.setLastName("Jaxon");
        Date dctrdob = new Date(1980/01/01);
        mockDoctor.setDob(dctrdob);
        mockDoctor.setPhoneNumber("123456789");

        // Object mapper
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(mockPatient);

        mockMvc.perform(MockMvcRequestBuilders.post("/Register")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson))
        .andExpect(MockMvcResultMatchers.status().isOk());

        // Object mapper 2 for registering the doctor
        ObjectMapper mapper2 = new ObjectMapper();
        mapper2.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter ow2 = mapper2.writer().withDefaultPrettyPrinter();
        String requestJson2 = ow2.writeValueAsString(mockDoctor);

        mockMvc.perform(MockMvcRequestBuilders.post("/Register")
        .contentType(MediaType.APPLICATION_JSON)
        .content(requestJson2))
        .andExpect(MockMvcResultMatchers.status().isOk());

        Appointment mockAppointment = new Appointment();
        mockAppointment.setPatient(mockPatient.getID());
        mockAppointment.setDoctorId(mockDoctor.getID());
        Date AppointmentDate = new Date(2022/10/01);
        mockAppointment.setDate(AppointmentDate);
        mockAppointment.setTime("14:30");
        mockAppointment.setTime("10:00");

        // Object mapper for appointment
        ObjectMapper Appointmapper = new ObjectMapper();
        Appointmapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
        ObjectWriter Appointow = Appointmapper.writer().withDefaultPrettyPrinter();
        String AppointrequestJson = Appointow.writeValueAsString(mockAppointment);

        Mockito.when(mockAppointmentApiController.saveAppointment(mockAppointment)).thenReturn("Appointment successfuly saved");

        mockMvc.perform(MockMvcRequestBuilders.post("/SetAppointment")
        .contentType(MediaType.APPLICATION_JSON)
        .content(AppointrequestJson))
        .andExpect(MockMvcResultMatchers.status().isOk());

        // If passed simulate adding user to mock database and return content-type application/json
        HttpHeaders header = new HttpHeaders();
        header.setContentType(MediaType.APPLICATION_JSON);

        Mockito.when(mockAppointmentRepo.findAppointmentByDoctorAndDateAndTime(Mockito.anyInt(), Mockito.any(Date.class), Mockito.anyString())).thenReturn(mockAppointment);
        // Mockito.when(mockApiController.validateAppointment(Mockito.anyInt(), Mockito.any(Date.class), Mockito.anyString())).thenReturn(true);
        Mockito.doReturn(true).when(mockAppointmentApiController).validateAppointment(Mockito.anyInt(), Mockito.any(Date.class), Mockito.anyString());

        mockMvc.perform(MockMvcRequestBuilders.get("/SearchAppointment/{id}/{date}/{start_time}", mockAppointment.getId(), mockAppointment.getDate(), mockAppointment.getTime()))
        .andExpect(MockMvcResultMatchers.status().isOk());
    }
}

