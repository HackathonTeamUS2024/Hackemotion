package com.example.emotion.control;

import com.example.emotion.db_access.UserRepository;
import com.example.emotion.db_access.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("")
public class SiteController {
    @Autowired
    UserRepository userRepository;
    User user = new User();
    @GetMapping("/hello")
    public String helloSite() {

        return "hello";
    }
    @GetMapping("/login")
    public String loginSite() {

        return "login";
    }
    @GetMapping("/gamePicture")
    public String gamePicture(@RequestParam String token) {
        if(!userRepository.findByToken(token).getToken().isEmpty()) {
            return "gamePicture";
        }
        return "hello";
    }
    @GetMapping("/gameRecording")
    public String gameRecording(@RequestParam String token) {
        if(!userRepository.findByToken(token).getToken().isEmpty()) {
            return "gameRecording";
        }
        return "hello";
    }
    @GetMapping("/learningMode")
    public String learningMode(@RequestParam String token) {
        if (!userRepository.findByToken(token).getToken().isEmpty()) {
            return "learningMode";
        }
        return "hello";
    }
}

