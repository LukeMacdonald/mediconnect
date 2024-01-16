package com.lukemacdonald.chatservice.service;

import com.lukemacdonald.chatservice.model.Message;

import java.util.List;

public interface MessageService {

    public List<Message> getMessages(int senderID, int receiverID);

    public Message getMessage( int messageID);

    public List<Message> getMessageMenu( int senderID);

    public Message saveMessage(Message message);

    public Message getUnread( int senderID, int receiverID);

    public void deleteUser(int id);
}
