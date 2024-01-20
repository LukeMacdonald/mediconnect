package com.lukemacdonald.chatservice.controller;

import com.lukemacdonald.chatservice.model.Message;
import com.lukemacdonald.chatservice.service.MessageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("messages")
public class MessageController {
    private final MessageService messageService;

    @GetMapping(value="")
    public ResponseEntity<?> getMessages(@RequestParam int senderID, @RequestParam int receiverID) {
        List<Message> messages = messageService.getMessages(senderID,receiverID);
        if(messages.isEmpty()){
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok().body(messages);
    }

    @GetMapping(value="/menu")
    public ResponseEntity<?> getMessageMenu(@RequestParam int senderID) {
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

    @GetMapping(value = "/unread")
    public ResponseEntity<?> getUnread(@RequestParam("senderID") int senderID, @RequestParam("receiverID") int receiverID){
        Message unread = messageService.getUnread(senderID,receiverID);
        if(unread != null){
            return ResponseEntity.ok().body(unread);
        }
        else{
            return ResponseEntity.badRequest().body("Error");
        }
    }
    @DeleteMapping(value = "")
    public void deleteUserMessages(@RequestParam("userID") int id){
        messageService.deleteUser(id);
    }
}
