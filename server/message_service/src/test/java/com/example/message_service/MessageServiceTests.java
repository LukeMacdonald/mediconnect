//package com.example.message_service;
//import java.time.LocalDate;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.List;
//
//import org.hamcrest.Matchers;
//import org.junit.Test;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.runner.RunWith;
//import org.mockito.Mockito;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.boot.test.mock.mockito.SpyBean;
//import org.springframework.data.jpa.convert.threeten.Jsr310JpaConverters;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.MediaType;
//import org.springframework.http.ResponseEntity;
//import org.springframework.test.context.junit4.SpringRunner;
//import org.springframework.test.web.servlet.MockMvc;
//import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
//import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
//import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
//
//
//import com.example.message_service.controller.MessageController;
//import com.example.message_service.model.Message;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.fasterxml.jackson.databind.ObjectWriter;
//import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;
//import com.fasterxml.jackson.datatype.jsr310.*;
//import com.fasterxml.jackson.module.paramnames.ParameterNamesModule;
//
//@RunWith(SpringRunner.class)
//@SpringBootTest
//@AutoConfigureMockMvc
//public class MessageServiceTests {
//
//    @Autowired
//    private MockMvc mockMvc;
//
//    @SpyBean
//    private MessageController messageController;
//
//    private Message message1;
//    private Message message2;
//    private Message message3;
//
//    ObjectMapper mapper = new ObjectMapper()
//   .registerModule(new ParameterNamesModule())
//   .registerModule(new Jdk8Module())
//   .registerModule(new JavaTimeModule());
//    ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
//
//    @BeforeEach
//    public void setup() {
//        message1 = new Message();
//        message2 = new Message();
//        message3 = new Message();
//
//        // Message ID
//        message1.setMessageID(1);
//        message2.setMessageID(2);
//        message3.setMessageID(3);
//
//        // Sender ID
//        message1.setSenderID(1);
//        message2.setSenderID(2);
//        message3.setSenderID(3);
//
//        // ReceiverID ID
//        message1.setReceiverID(1);
//        message2.setReceiverID(2);
//        message3.setReceiverID(3);
//
//        // Message
//        message1.setMessage("Message 1");
//        message2.setMessage("Message 2");
//        message3.setMessage("Message 3");
//
//
//        // Timestamp
//        message1.setTimestamp(Date.now());
//        message2.setTimestamp(Date.now());
//        message3.setTimestamp(Date.now());
//
//        // Viewed
//        message1.setViewed(false);
//        message2.setViewed(true);
//        message3.setViewed(false);
//    }
//
//    @Test
//    public void MessagesReceived_NotEmpty_MessagesReceivedSuccessfully() throws Exception {
//        setup();
//
//        List<Message> messageList = new ArrayList<>();
//
//        int senderID = 1;
//        int receiverId = 1;
//
//        message1.setSenderID(senderID);
//        message2.setSenderID(senderID);
//        message3.setSenderID(senderID);
//
//        message1.setReceiverID(receiverId);
//        message2.setReceiverID(receiverId);
//        message3.setReceiverID(receiverId);
//
//        messageList.add(message1);
//        messageList.add(message2);
//        messageList.add(message3);
//
//        String expectedResponse = ow.writeValueAsString(messageList);
//
//        ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(expectedResponse);
//
//        Mockito.doReturn(responseEntity).when(messageController).getMessages(senderID, receiverId);
//
//        mockMvc.perform(
//            MockMvcRequestBuilders.get("/get/messages/{senderID}/{receiverID}", senderID, receiverId)
//            .contentType(MediaType.APPLICATION_JSON))
//            .andExpect(MockMvcResultMatchers.status().isOk())
//            .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
//            .andExpect(jsonPath("$.[0].message", Matchers.is("Message 1")))
//            .andExpect(jsonPath("$.[1].message", Matchers.is("Message 2")))
//            .andExpect(jsonPath("$.[2].message", Matchers.is("Message 3"))
//        );
//    }
//
//    @Test
//    public void getMessageMenu_NotEmpty_MessagesReceivedSuccessfully() throws Exception {
//        setup();
//
//        List<Message> messageList = new ArrayList<>();
//
//        int senderID = 1;
//
//        message1.setSenderID(senderID);
//        message2.setSenderID(senderID);
//        message3.setSenderID(senderID);
//
//        messageList.add(message1);
//        messageList.add(message2);
//        messageList.add(message3);
//
//        String expectedResponse = ow.writeValueAsString(messageList);
//
//        ResponseEntity responseEntity = ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(expectedResponse);
//
//        Mockito.doReturn(responseEntity).when(messageController).getMessageMenu(senderID);
//
//        mockMvc.perform(
//            MockMvcRequestBuilders.get("/get/message_menu/{senderID}", senderID)
//            .contentType(MediaType.APPLICATION_JSON))
//            .andExpect(MockMvcResultMatchers.status().isOk())
//            .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
//            .andExpect(jsonPath("$.[0].message", Matchers.is("Message 1")))
//            .andExpect(jsonPath("$.[1].message", Matchers.is("Message 2")))
//            .andExpect(jsonPath("$.[2].message", Matchers.is("Message 3"))
//        );
//    }
//
//    @Test
//    public void MessageSent_ErrorNotThrown_MessagePostedSuccessfully() throws Exception {
//        setup();
//        String messageJson = ow.writeValueAsString(message1);
//
//        Mockito.when(messageController.sendMessage(message1)).thenReturn(message1);
//
//        mockMvc.perform(MockMvcRequestBuilders.post("/post/message")
//        .contentType(MediaType.APPLICATION_JSON)
//        .content(messageJson))
//        .andExpect(MockMvcResultMatchers.status().isOk())
//        .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
//        .andExpect(jsonPath("$.message", Matchers.is("Message 1")));
//    }
//}
