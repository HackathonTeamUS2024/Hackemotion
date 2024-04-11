package com.example.emotion.db_access;

import org.springframework.web.bind.annotation.RestController;

@RestController
public class User {
    private long userId;
    private String email;
    private String password;
    private String name;
    private String surname;
    private Integer birthYear;
    private String sex;
    private String placeOfResidence;
    private String additionalInformation;

    public User() {}

    public User(long userId, String email, String password, String name, String surname, Integer birthYear, String sex, String placeOfResidence, String additionalInformation) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.name = name;
        this.surname = surname;
        this.birthYear = birthYear;
        this.sex = sex;
        this.placeOfResidence = placeOfResidence;
        this.additionalInformation = additionalInformation;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public Integer getBirthYear() {
        return birthYear;
    }

    public void setBirthYear(Integer birthYear) {
        this.birthYear = birthYear;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPlaceOfResidence() {
        return placeOfResidence;
    }

    public void setPlaceOfResidence(String placeOfResidence) {
        this.placeOfResidence = placeOfResidence;
    }

    public String getAdditionalInformation() {
        return additionalInformation;
    }

    public void setAdditionalInformation(String additionalInformation) {
        this.additionalInformation = additionalInformation;
    }

}
