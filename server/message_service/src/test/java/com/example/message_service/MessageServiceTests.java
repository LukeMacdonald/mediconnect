package com.example.message_service;
import java.time.LocalDate;

import org.junit.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.SpyBean;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import com.example.message_service.controller.MessageController;
import com.example.message_service.model.Message;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
public class MessageServiceTests {
    
    @Autowired
    private MockMvc mockMvc;

    @SpyBean
    private MessageController messageController;

    private Message message1;
    private Message message2;
    private Message message3;

    @BeforeEach
    public void setup() {
        message1 = new Message();
        message2 = new Message();
        message3 = new Message();

        // Message ID
        message1.setMessageID(1);
        message2.setMessageID(2);
        message3.setMessageID(3);

        // Sender ID
        message1.setSenderID(1);
        message2.setSenderID(2);
        message3.setSenderID(3);

        // ReceiverID ID
        message1.setReceiverID(1);
        message2.setReceiverID(2);
        message3.setReceiverID(3);

        // Message
        message1.setMessage("Message 1");
        message2.setMessage("Message 2");
        message3.setMessage("Message 3");

        // Timestamp
        message1.setTimestamp(LocalDate.now());
        message2.setTimestamp(LocalDate.now());
        message3.setTimestamp(LocalDate.now());

        // Viewed
        message1.setViewed(false);
        message2.setViewed(true);
        message3.setViewed(false);
    }

    @Test
    public void contextLoads() {
        
    }
}
