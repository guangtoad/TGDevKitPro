package com.toad.devkit.pro.web;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(exclude = {})
public class DevkitWebApplication {
    public static void main(String[] args) {
        SpringApplication.run(DevkitWebApplication.class, args);
    }
}
