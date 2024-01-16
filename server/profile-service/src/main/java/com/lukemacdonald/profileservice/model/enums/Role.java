package com.lukemacdonald.profileservice.model.enums;

public enum Role {
    patient(1),
    doctor(2),
    admin(3);

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
