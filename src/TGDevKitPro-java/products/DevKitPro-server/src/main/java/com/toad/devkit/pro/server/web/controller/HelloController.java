package com.toad.devkit.pro.server.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;

@Controller
@RequestMapping("/hello")
public class HelloController {
    
    @GetMapping("/hello")
    public String hello(Model model) {
        model.addAttribute("message", "Hello Thymeleaf!");
        return "hello"; // 对应 templates/hello.html
    }
}