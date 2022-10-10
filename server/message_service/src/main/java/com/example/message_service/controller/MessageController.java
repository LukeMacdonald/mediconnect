package com.example.message_service.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.message_service.model.Message;
import com.example.message_service.service.MessageService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class MessageController {
    private final MessageService messageService;

    @GetMapping(value="/get/messages/{senderID}/{receiverID}")
    public ResponseEntity<?> getMessages(@PathVariable("senderID") int senderID,  @PathVariable("receiverID") int receiverID) {
        List<Message> messages = messageService.getMessages(senderID,receiverID);
        if(messages.isEmpty()){
            return ResponseEntity.badRequest().body("No Messages Available");
        }
        return ResponseEntity.ok().body(messages);
    }

    @GetMapping(value="/get/messages/{messageID}")
    public ResponseEntity<?> getMessage(@PathVariable("messageID") int messageID) {
        Message message = messageService.getMessage(messageID);
        if(message == null){
            return ResponseEntity.badRequest().body("Message Not Available");
        }
        return ResponseEntity.ok().body(message);
    }

    @GetMapping(value="/get/message_menu/{senderID}")
    public ResponseEntity<?> getMessageMenu(@PathVariable("senderID") int senderID) {
        List<?> individual = messageService.getMessageMenu(senderID);
        if(individual.isEmpty()){
            return ResponseEntity.badRequest().body("No Previous Messages Available");
        }
        return ResponseEntity.ok(individual);
    }

    @PostMapping(value="/post/message")
    public Message sendMessage(@RequestBody Message message) {
        return messageService.sendMessage(message);
    }
    @GetMapping(value = "/get/unread/message/{senderID}/{receiverID}")
    public ResponseEntity<?> getUnread(@PathVariable("senderID") int senderID, @PathVariable("receiverID") int receiverID){
        Message unread = messageService.getUnread(senderID,receiverID);
        if(unread != null){
            return ResponseEntity.ok().body(unread);
        }
        else{
            return ResponseEntity.badRequest().body("Error");
        }

    }
}
