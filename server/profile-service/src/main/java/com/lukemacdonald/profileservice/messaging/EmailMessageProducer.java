package com.lukemacdonald.profileservice.messaging;

import com.lukemacdonald.profileservice.model.EmailMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailMessageProducer {

    private final RabbitTemplate rabbitTemplate;


    public void sendMessage(EmailMessage emailMessage){

        rabbitTemplate.convertAndSend("sendEmailQueue", emailMessage);

    }



}
