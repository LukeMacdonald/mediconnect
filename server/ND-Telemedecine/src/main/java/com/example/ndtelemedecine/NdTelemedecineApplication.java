package com.example.ndtelemedecine;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class NdTelemedecineApplication {

    // Default port 8080: localhost:8080/
    // Default mySQL Database port 3306:
    public static void main(String[] args) {
        SpringApplication.run(NdTelemedecineApplication.class, args);
    }
}
