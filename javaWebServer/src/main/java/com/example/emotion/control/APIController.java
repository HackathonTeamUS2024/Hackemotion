package com.example.emotion.control;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class APIController {
    @PostMapping("/login")
    public String login(@RequestParam String name, @RequestParam String password) {
        return "helo man";
    }
}