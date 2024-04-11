package com.example.emotion.control;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("")
public class SiteController {
    @GetMapping("/hello")
    public String helloSite() {
        return "hello";
    }
}
