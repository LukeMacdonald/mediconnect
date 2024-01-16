package com.lukemacdonald.profileservice.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmailMessage {
    private String recipient;
    private String msgBody;
    private String subject;
    private String attachment;
}