package com.example.message_service.controller;

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
        return messageService.findBySenderIDAndReceiverID(senderID, receiverID);
    }

    @GetMapping(value="/get/messages/{messageID}")
    public ResponseEntity<Message> getMessage(@PathVariable("messageID") int messageID) {
        return ResponseEntity.ok().body(messageService.findByMessageID(messageID));
    }

    @GetMapping(value="/get/message_menu/{senderID}")
    public List<Message> getMessageMenu(@PathVariable("senderID") int senderID) {
        return messageService.findBySenderIDOrderByReceiverID(senderID);
    }

    @PostMapping(value="/post/message")
    public Message sendMessage(@RequestBody Message message) {
        return messageService.save(message);
    }
}
