package com.example.emotion.control;

import com.example.emotion.db_access.User;
import com.example.emotion.db_access.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

@RestController
@Service
@RequestMapping("/api")
public class APIController {
    @Autowired
    private UserRepository userRepository;
    private final ObjectNode response = JsonNodeFactory.instance.objectNode();
    @Transactional
    @PostMapping("/login")
    public ObjectNode login(@RequestParam String email, @RequestParam String password) throws NoSuchAlgorithmException {
        ObjectNode response = JsonNodeFactory.instance.objectNode();
        User UserLog = userRepository.findByEmail(email);
        MessageDigest md = MessageDigest.getInstance("SHA-512");
            if(UserLog.login(password)) {
                response.put("message", 1);
                return response;
            }
        return response.put("message", 0);
    }
    @PostMapping("/register")
    public ObjectNode register(@RequestParam String email,
                               @RequestParam String password,
                               @RequestParam String name,
                               @RequestParam String surname,
                               @RequestParam Integer birthYear,
                               @RequestParam String sex,
                               @RequestParam String placeOfResidence) throws NoSuchAlgorithmException {
        ObjectNode response = JsonNodeFactory.instance.objectNode();
        User newUser = new User(email,password,name,surname,birthYear,sex,placeOfResidence);
        try {
            saveUser(newUser);
        }
        catch (Exception e) {
            response.put("message", e.getMessage());
        }
        response.put("haslo", newUser.getPassword());
        response.put("message", "Registered successfully");
        return response;
    }
    @RequestMapping(value="/getRes", method = RequestMethod.GET)
    public @ResponseBody String getRes(@RequestParam String type){
        return "Chciany typ: " + type;
    }
    public void saveUser(User user) {
        userRepository.save(user);
    }
}