package com.lukemacdonald.chatservice.repository;

import com.lukemacdonald.chatservice.model.Message;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MessageRepo extends JpaRepository<Message, Long> {
    List<Message> findBySenderIDAndReceiverID(int senderID, int receiverID);
    List<Message>   findBySenderIDOrderByReceiverID(int senderID);
    List<Message>   findBySenderIDOrderByTimestampAsc(int senderID);

    List<Message>   findByReceiverIDOrderByTimestampAsc(int receiverID);

    Message         findByMessageID(int messageID);
    List<Message>   findBySenderIDAndReceiverIDAndViewedOrderByTimestampAsc(int senderID, int receiverID,boolean viewed);

    List<Message> findAllBySenderID(int senderID);

    List<Message> findAllByReceiverID(int receiverID);



}
