package com.example.prescription_service.exception;

public class EmptyListException extends RuntimeException {
    private static final long serialVersionUID = 1L;
    
    public EmptyListException(String exception) {
        super(exception);
    }
}
