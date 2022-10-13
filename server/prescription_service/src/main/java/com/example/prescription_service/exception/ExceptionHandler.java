package com.example.prescription_service.exception;

import java.util.Date;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.WebRequest;


@ControllerAdvice
public class ExceptionHandler {
    
    @org.springframework.web.bind.annotation.ExceptionHandler(value=EmptyListException.class)
    public ResponseEntity<ExceptionMessage> emptyListException(EmptyListException ex, WebRequest request) {
        ExceptionMessage exceptionMessage = new ExceptionMessage(
            400, 
            new Date(), 
            ex.getMessage(), 
            request.getDescription(false)
        );

        return new ResponseEntity<ExceptionMessage>(exceptionMessage, HttpStatus.BAD_REQUEST);
    }

    @org.springframework.web.bind.annotation.ExceptionHandler(value=PrescriptionNotExists.class)
    public ResponseEntity<ExceptionMessage> prescriptionNotExists(PrescriptionNotExists ex, WebRequest request) {
        ExceptionMessage exceptionMessage = new ExceptionMessage(
            400, 
            new Date(), 
            ex.getMessage(),
            request.getDescription(false)
        );

        return new ResponseEntity<ExceptionMessage>(exceptionMessage, HttpStatus.BAD_REQUEST);
    }
}
