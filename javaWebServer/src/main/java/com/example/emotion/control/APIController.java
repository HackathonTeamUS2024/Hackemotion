package com.example.emotion.control;

import com.example.emotion.db_access.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;

@RestController
@Service
@RequestMapping("/api")
public class APIController {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ResourceRepository resourceRepository;
    @Autowired
    private Training_SessionRepository trainingSessionRepository;
    @Autowired
    private Training_Session_ResultRepository trainingSessionResultRepository;
    private final ObjectNode response = JsonNodeFactory.instance.objectNode();
    @Transactional
    @PostMapping("/login")
    public ObjectNode login(@RequestParam String email, @RequestParam String password) throws NoSuchAlgorithmException {
        ObjectNode response = JsonNodeFactory.instance.objectNode();
        User UserLog = userRepository.findByEmail(email);
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        try {
            if (UserLog.login(password)) {
                response.put("message", 1);
                UUID uuid = UUID.randomUUID();
                userRepository.updateToken(email,uuid.toString());
                response.put("token", uuid.toString());
                return response;
            }
        }
        catch(Exception e){
            return response.put("message", e.getMessage());
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
        response.put("message", "Registered successfully");
        return response;
    }
    public int getRandomNumber(int min, int max) {
        return (int) ((Math.random() * (max - min)) + min);
    }
    @RequestMapping(value="/getRes", method = RequestMethod.GET)
    public @ResponseBody String[] getRes(@RequestParam String type){
        String[] pickedFiles = new String[15];
        List<Resource> files = resourceRepository.findRandomResource(type);
        for(int i=0;i<15;i++){
            pickedFiles[i]=files.get(getRandomNumber(0,files.size())-1).getPath();
        }
        return pickedFiles;
    }
    @RequestMapping(value="/answers", method = RequestMethod.POST)
    public @ResponseBody String postAnswers(@RequestParam List<String> drawn, @RequestParam List<String> answered, long userId){
        Training_Session newSession = new Training_Session();
        newSession.setSessionId(UUID.randomUUID().toString());
        newSession.setUserId(userId);
        trainingSessionRepository.save(newSession);
        for(int i=0;i<drawn.size()-1;i++){
            Training_Session_Result newSessionResult = new Training_Session_Result();
            newSessionResult.setDrawn(drawn.get(i));
            newSessionResult.setAnswer(answered.get(i));
            trainingSessionResultRepository.save(newSessionResult);
        }
        return "done";
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }
}