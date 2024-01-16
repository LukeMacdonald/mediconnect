package com.lukemacdonald.chatservice.service;

import com.lukemacdonald.chatservice.model.Message;
import com.lukemacdonald.chatservice.repository.MessageRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {

    private final MessageRepo messageRepo;
    public List<Message> getMessages(int senderID, int receiverID) {
        List<Message> messages = messageRepo.findBySenderIDAndReceiverID(senderID, receiverID);
        messages.addAll(messageRepo.findBySenderIDAndReceiverID(receiverID, senderID));
        return messages.stream()
                .sorted(Comparator.comparing(Message::getTimestamp))
                .collect(Collectors.toList());
    }
    public Message getMessage( int messageID) {
        return messageRepo.findByMessageID(messageID);
    }
    public List<Message> getMessageMenu( int senderID) {

        List<Message> all_sender = messageRepo.findBySenderIDOrderByTimestampAsc(senderID);
        List<Message> individual = new ArrayList<>();
        List<Integer> ids = new ArrayList<>();

        for (Message message : all_sender) {
            if (!ids.contains(message.getReceiverID())) {
                individual.add(message);
                ids.add(message.getReceiverID());
            }
        }
        List<Message> all_receiver = messageRepo.findByReceiverIDOrderByTimestampAsc(senderID);

        for (Message message : all_receiver){
            if(!ids.contains(message.getSenderID())){
                individual.add(message);
                ids.add(message.getSenderID());
            }
        }
        return individual;
    }
    public Message saveMessage(Message message) {
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

    public void deleteUser(int id){
        List<Message> messages = messageRepo.findAllByReceiverID(id);
        messages.addAll(messageRepo.findAllBySenderID(id));
        messageRepo.deleteAll(messages);
    }
}
