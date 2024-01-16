package com.lukemacdonald.notificationservice.messaging;

import com.lukemacdonald.notificationservice.dto.EmailDetails;
import com.lukemacdonald.notificationservice.service.EmailService;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;


@Service
@RequiredArgsConstructor
public class EmailMessageConsumer {

    private final EmailService emailService;

    @RabbitListener(queues = "sendEmailQueue")
    private void consumeMessage(EmailDetails emailDetails) throws MessagingException {

        emailService.sendSimpleMail(emailDetails);

    }

}
