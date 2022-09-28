package com.example.message_service.service;

import com.example.message_service.model.Message;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;


public interface MessageService extends JpaRepository<Message, Long> {
    List<Message>   findBySenderIDAndReceiverID(int senderID, int receiverID);
    List<Message>   findBySenderIDOrderByReceiverID(int senderID);
    Message         findByMessageID(int messageID);
}
