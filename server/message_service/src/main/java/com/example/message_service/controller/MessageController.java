package com.example.message_service.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.message_service.model.Message;
import com.example.message_service.service.MessageService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class MessageController {
    private final MessageService messageService;

    @GetMapping(value="/get/messages/{senderID}/{receiverID}")
    public List<Message> getMessages(@PathVariable("senderID") int senderID,  @PathVariable("receiverID") int receiverID) {
        List<Message> messages = messageService.findBySenderIDAndReceiverID(senderID, receiverID);
        messages.addAll(messageService.findBySenderIDAndReceiverID(receiverID, senderID));
        return messages;
    }

    @GetMapping(value="/get/messages/{messageID}")
    public ResponseEntity<Message> getMessage(@PathVariable("messageID") int messageID) {
        return ResponseEntity.ok().body(messageService.findByMessageID(messageID));
    }

    @GetMapping(value="/get/message_menu/{senderID}")
    public List<Message> getMessageMenu(@PathVariable("senderID") int senderID) {

        List<Message> all = messageService.findBySenderIDOrderByTimestampAsc(senderID);
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

    @PostMapping(value="/post/message")
    public Message sendMessage(@RequestBody Message message) {
        return messageService.save(message);
    }

    @GetMapping(value = "/get/unread/message/{senderID}/{receiverID}")
    public ResponseEntity getUnread(@PathVariable("senderID") int senderID, @PathVariable("receiverID") int receiverID){
        List<Message> unread = messageService.findBySenderIDAndReceiverIDAndViewedOrderByTimestampAsc(receiverID,senderID,false);
        if(!unread.isEmpty()){
            unread.get(0).setViewed(true);
            messageService.save(unread.get(0));
            return ResponseEntity.ok().body(unread.get(0));
        }
        else{
            return ResponseEntity.badRequest().body("Error");
        }

    }
}
