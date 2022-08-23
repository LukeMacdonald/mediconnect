package com.example.ndtelemedecine;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController{    
    
    @RequestMapping(value="/") //localhost:8080/
    public String Home() {
        return "On Home Page";
    }

    @RequestMapping(value="/User")
    public String Users() {
        return "In /User";
    }
}