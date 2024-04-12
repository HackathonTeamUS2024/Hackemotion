package com.example.emotion.db_access;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Column;
import jakarta.validation.constraints.*;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.LocalDate;
import java.util.Arrays;

@Entity
public class User {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name="userId")
    private long userId;

    private String email;
    private String token;
    private byte[] password = new byte[64];
    private byte[] salt = new byte[32];

    private String name;

    private String surname;
    @Column(name="birthYear")

    private Integer birthYear;

    private String sex;
    @Column(name="placeOfResidence")
    private String placeOfResidence;

    @Column(name="additionalInformation")

    private String additionalInformation;

    public User() {}

    public User( String email, String password, String name, String surname, Integer birthYear, String sex, String placeOfResidence) throws NoSuchAlgorithmException {
        setEmail(email);
        setPassword(password);
        setName(name);
        setSurname(surname);
        setBirthYear(birthYear);
        setSex(sex);
        setPlaceOfResidence(placeOfResidence);
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public byte[] getSalt() {
        return salt;
    }

    public void setSalt(byte[] salt) {
        this.salt = salt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public byte[] getPassword() {
        return password;
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
        //int currentYear = LocalDate.now().getYear();
        if(birthYear <= 2021) {
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
        if(placeOfResidence.equals("village") || placeOfResidence.equals("smallTown") ||
                placeOfResidence.equals("midTown") || placeOfResidence.equals("bigTown") ) {
            this.placeOfResidence = placeOfResidence;
        }
        // village
        // smallTown < 20k
        // midTown > 20k-100k
        // bigTown > 100k
        else throw new IllegalArgumentException("Nieprawidlowa wielkosc miasta");
    }

    public String getAdditionalInformation() {
        return additionalInformation;
    }

    public void setAdditionalInformation(String additionalInformation) {
        this.additionalInformation = additionalInformation;
    }
    public void setPassword(String password) throws NoSuchAlgorithmException {
        SecureRandom random = new SecureRandom();
        random.nextBytes(salt);
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.update(salt);
        setSalt(salt);
        this.password = md.digest(password.getBytes(StandardCharsets.UTF_8));
    }
    public boolean login(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.update(this.salt);
        return Arrays.equals(this.password, md.digest(password.getBytes(StandardCharsets.UTF_8)));
    }

}