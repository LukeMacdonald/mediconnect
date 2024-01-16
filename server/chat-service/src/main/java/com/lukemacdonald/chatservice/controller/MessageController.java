package com.lukemacdonald.chatservice.controller;

import com.lukemacdonald.chatservice.model.Message;
import com.lukemacdonald.chatservice.service.MessageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("message")
public class MessageController {
    private final MessageService messageService;

    @GetMapping(value="/get/{senderID}/{receiverID}")
    public ResponseEntity<?> getMessages(@PathVariable("senderID") int senderID, @PathVariable("receiverID") int receiverID) {
        List<Message> messages = messageService.getMessages(senderID,receiverID);
        if(messages.isEmpty()){
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok().body(messages);
    }

    @GetMapping(value="/get/single/{messageID}")
    public ResponseEntity<?> getMessage(@PathVariable("messageID") int messageID) {
        Message message = messageService.getMessage(messageID);
        if(message == null){
            return ResponseEntity.badRequest().body("Message Not Available");
        }
        return ResponseEntity.ok().body(message);
    }

    @GetMapping(value="/menu/{senderID}")
    public ResponseEntity<?> getMessageMenu(@PathVariable("senderID") int senderID) {
        List<?> individual = messageService.getMessageMenu(senderID);
        if(individual.isEmpty()){
            return ResponseEntity.badRequest().body("No Previous Messages Available");
        }
        return ResponseEntity.ok(individual);
    }

    @PostMapping(value="/post")
    public Message sendMessage(@RequestBody Message message) {
        return messageService.saveMessage(message);
    }
    @GetMapping(value = "/unread/{senderID}/{receiverID}")
    public ResponseEntity<?> getUnread(@PathVariable("senderID") int senderID, @PathVariable("receiverID") int receiverID){
        Message unread = messageService.getUnread(senderID,receiverID);
        if(unread != null){
            return ResponseEntity.ok().body(unread);
        }
        else{
            return ResponseEntity.badRequest().body("Error");
        }
    }
    @DeleteMapping(value = "/delete/user/{id}")
    public void deleteUserMessages(@PathVariable("id") int id){
        messageService.deleteUser(id);
    }
}
