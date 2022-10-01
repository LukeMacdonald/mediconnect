package com.example.message_service.service;

import com.example.message_service.model.Message;

import java.util.ArrayList;
import java.util.List;

import com.example.message_service.repository.MessageRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

@Service
@RequiredArgsConstructor
public class MessageService{
    private final MessageRepo messageRepo;
    public List<Message> getMessages( int senderID,int receiverID) {
        List<Message> messages = messageRepo.findBySenderIDAndReceiverID(senderID, receiverID);
        messages.addAll(messageRepo.findBySenderIDAndReceiverID(receiverID, senderID));
        return messages;
    }
    public Message getMessage( int messageID) {
        return messageRepo.findByMessageID(messageID);
    }
    public List<Message> getMessageMenu( int senderID) {
        List<Message> all = messageRepo.findBySenderIDOrderByTimestampAsc(senderID);
        List<Message> individual = new ArrayList<>();
        List<Integer> ids = new ArrayList<>();

        for (Message message : all) {
            if (!ids.contains(message.getReceiverID())) {
                individual.add(message);
                ids.add(message.getReceiverID());
            }
        }
        return individual;
    }
    public Message sendMessage(@RequestBody Message message) {
        return messageRepo.save(message);
    }
    public Message getUnread( int senderID, int receiverID){
        List<Message> unread = messageRepo.findBySenderIDAndReceiverIDAndViewedOrderByTimestampAsc(receiverID,senderID,false);
        if(!unread.isEmpty()) {
            unread.get(0).setViewed(true);
            messageRepo.save(unread.get(0));
            return unread.get(0);
        }
        return null;
    }
}






