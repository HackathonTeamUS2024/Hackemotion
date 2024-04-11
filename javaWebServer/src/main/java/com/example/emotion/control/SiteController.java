package com.example.emotion.control;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("")
public class SiteController {
    @GetMapping("/hello")
    public String helloSite() {
        return "hello";
    }
    @GetMapping("/login")
    public String loginSite() {
        return "login";
    }
    @GetMapping("/gamePicture")
    public String gamePicture() {
        return "gamePicture";
    }
    @GetMapping("/gameRecording")
    public String gameRecording() {
        return "gameRecording";
    }
    @GetMapping("/learningMode")
    public String learningMode() {
        return "learningMode";
    }
}

