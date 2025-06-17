package com.toad.devkit.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication(exclude = {})
@ComponentScan({"com.toad.devkit.server"})
public class DevkitServerApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(DevkitServerApplication.class, args);
    }
}
