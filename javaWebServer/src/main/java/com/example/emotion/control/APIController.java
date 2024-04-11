package com.example.emotion.control;

import com.example.emotion.db_access.User;
import com.example.emotion.db_access.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@RestController
@RequestMapping("/api")
public class APIController {
    @Autowired
    private UserRepository userRepository;
    private final ObjectNode response = JsonNodeFactory.instance.objectNode();
    @PostMapping("/login")
    public ObjectNode login(@RequestParam String email, @RequestParam String password) throws NoSuchAlgorithmException {
        ObjectNode response = JsonNodeFactory.instance.objectNode();
        User UserLog = userRepository.findByEmail(email);
        if (UserLog == null) {
            response.put("message", "User does not exist.");
            return response;
        }
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.update(UserLog.getSalt());
        if(UserLog.getPassword()==md.digest(password.getBytes(StandardCharsets.UTF_8))){
            response.put("message", "Success");
            response.put("token", "/Generate token/");
            return response;
        }
        response.put("message", "failure");
        return response;
    }
    @PostMapping("/register")
    public ObjectNode register(@RequestParam String email,
                               @RequestParam String password,
                               @RequestParam String name,
                               @RequestParam String surname,
                               @RequestParam Integer birthYear,
                               @RequestParam String sex,
                               @RequestParam String placeOfResidence,
                               @RequestParam String additionalInformation) {
        ObjectNode response = JsonNodeFactory.instance.objectNode();
//        try{
//            User newUser = new User(email,password,name,surname,birthYear,sex,placeOfResidence,additionalInformation);
//        }
//        catch (Exception e){
//            response.put("message", e.getMessage());
//            return response;
//        }
        response.put("data1",email);
        response.put("data2",password);
        response.put("data3",name);
        response.put("data4",surname);
        response.put("data5",birthYear);
        response.put("data6",sex);
        response.put("data7",placeOfResidence);
        response.put("data8",additionalInformation);
        response.put("message", "Registered successfully");
        return response;
    }
}