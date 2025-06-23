package com.toad.devkit.pro.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(exclude = {})
public class DevKitProServerApplication {
    public static void main(String[] args) {
        SpringApplication.run(DevKitProServerApplication.class, args);
    }
}
