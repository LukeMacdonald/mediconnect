package com.example.prescription_service.exception;

public class UserEmailNotValid extends RuntimeException {
    // In truth this exception should literally never run.
    // There are already measures in place to make sure a user can not be made without their email.
    // But why the heck not. (Not actually called in any functions but proof of concept here:)
    private static final long serialVersionUID = 1L;
    
    public UserEmailNotValid(String exception) {
        super(exception);
    }
}
