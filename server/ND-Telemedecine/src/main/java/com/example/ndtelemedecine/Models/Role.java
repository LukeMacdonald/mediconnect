package com.example.ndtelemedecine.Models;

public enum Role {
    patient(1),
    doctor(2),
    superuser(3);

    private final int value;

    Role(final int value) {
        this.value = value;
    }

    public int getRoleValue() {
        return this.value;
    }

    public String getRoleName() {
        return this.name();
    }
}
