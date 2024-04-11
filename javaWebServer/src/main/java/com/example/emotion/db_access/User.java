package com.example.emotion.db_access;

import jakarta.validation.constraints.*;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

@RestController
public class User {
    @NotNull @NotEmpty
    private long userId;
    @NotNull @NotEmpty @Email
    private String email;
    @NotNull @NotEmpty
    @Pattern(regexp ="\"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{6,13}$\"")
    // Walidacja hasla:
    // - 8 znakow min, 15 znakow max
    // - co najmniej 1 znak specjalny
    // - co najmniej 1 liczba
    // - co najmniej 1 duza litera
    private String password;
    @NotNull @NotEmpty @Size(max=30)
    private String name;
    @NotNull @NotEmpty @Size(max=30)
    private String surname;
    @NotNull @NotEmpty
    private Integer birthYear;
    @NotNull @NotEmpty
    private String sex;
    @NotNull @NotEmpty
    private String placeOfResidence;
    @Size(max=256)
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
        int currentYear = LocalDate.now().getYear();
        if(currentYear - birthYear >= 3) {
            this.birthYear = birthYear;
        } else {
            throw new IllegalArgumentException("Uczestnik nie moze miec mniej niz 3 lata");
        }

    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        if (sex.equals("male") || sex.equals("female")) {
            this.sex = sex;
        } else {
            throw new IllegalArgumentException("Nieprawidłowa płeć");
        }
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
