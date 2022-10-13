package com.example.prescription_service.exception;

public class PrescriptionNotExists extends RuntimeException{
    private static final long serialVersionUID = 1L;
    
    public PrescriptionNotExists(String exception) {
        super(exception);
    }
}
