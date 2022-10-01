package com.example.message_service.repository;

import com.example.message_service.model.Message;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MessageRepo extends JpaRepository<Message, Long> {
    List<Message>   findBySenderIDAndReceiverID(int senderID, int receiverID);
    List<Message>   findBySenderIDOrderByReceiverID(int senderID);
    List<Message>   findBySenderIDOrderByTimestampAsc(int senderID);
    Message         findByMessageID(int messageID);
    List<Message>   findBySenderIDAndReceiverIDAndViewedOrderByTimestampAsc(int senderID, int receiverID,boolean viewed);

}
