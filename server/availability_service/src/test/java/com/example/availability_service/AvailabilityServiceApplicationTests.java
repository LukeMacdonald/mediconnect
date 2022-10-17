package com.example.availability_service;

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

import com.example.availability_service.controller.AvailabilityController;
import com.example.availability_service.model.Availability;
import com.example.availability_service.repository.AvailabilityRepo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
public class AvailabilityServiceApplicationTests {

	@Autowired
    private MockMvc mockMvc;

    @SpyBean
    private AvailabilityController availabilityController;

	@MockBean
	private AvailabilityRepo availabilityRepo;

	Availability availability1;
	Availability availability2;
	Availability availability3;

	ObjectMapper mapper = new ObjectMapper();
    ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();

	@BeforeEach
    public void setup() {
        availability1 = new Availability();
        availability2 = new Availability();
        availability3 = new Availability();

        // ID
        availability1.setdoctor_id(1);
        availability2.setdoctor_id(2);
        availability3.setdoctor_id(3);

        // StartTime
        availability1.setstart_time("00:00:00");
        availability2.setstart_time("10:00:00");
        availability3.setstart_time("09:00:00");

        // EndTime
        availability1.setstart_time("10:00:00");
        availability2.setstart_time("12:00:00");
        availability3.setstart_time("23:00:00");

        // Day of week
        availability1.setday_of_week(1);
        availability2.setday_of_week(2);
        availability3.setday_of_week(3);
    }

    @Test
    public void addAvailability_NoErrorThrown_AvailabilityAddedSuccessfully() throws Exception {
        setup();
       ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body("Availability set!");
       String expectedResponse = ow.writeValueAsString(availability1);
       Mockito.doReturn(responseEntity).when(availabilityController).availability(availability1);


       mockMvc.perform(MockMvcRequestBuilders.post("/doctor/set/availability")
	   .contentType(MediaType.APPLICATION_JSON)
	   .content(expectedResponse))
       .andExpect(MockMvcResultMatchers.status().isOk()
       );
    }

	@Test
    public void removeAvailability_NoErrorThrown_AvailabilityRemovedSuccessfully() throws Exception {
       setup();

       String expectedResponse = ow.writeValueAsString(availability1);
	   Mockito.doNothing().when(availabilityRepo).delete(availability1);
       Mockito.doNothing().when(availabilityController).removeAvailability(availability1);

       mockMvc.perform(MockMvcRequestBuilders.delete("/remove/availability")
	   .contentType(MediaType.APPLICATION_JSON)
	   .content(expectedResponse))
       .andExpect(MockMvcResultMatchers.status().isOk());
    }
}
