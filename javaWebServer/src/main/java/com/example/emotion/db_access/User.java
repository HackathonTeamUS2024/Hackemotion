package com.example.emotion.db_access;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.RestController;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.LocalDate;

@Entity
public class User {
    @Id
    @NotNull @NotEmpty
    @GeneratedValue(strategy= GenerationType.AUTO)
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
    private byte[] password;
    private byte[] salt;
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

    public User( String email, String password, String name, String surname, Integer birthYear, String sex, String placeOfResidence, String additionalInformation) throws NoSuchAlgorithmException {
        SecureRandom random = new SecureRandom();
        setEmail(email);
        setPassword(password);
        random.nextBytes(salt);
        setName(name);
        setSurname(surname);
        setBirthYear(birthYear);
        setSex(sex);
        setPlaceOfResidence(placeOfResidence);
        setAdditionalInformation(additionalInformation);
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
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

    public void setPassword(String password) throws NoSuchAlgorithmException {
        if(password==null || password.isEmpty()){ throw new NullPointerException();}
        if(!password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{6,13}$")){ throw new IllegalArgumentException(); }
        SecureRandom random = new SecureRandom();
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.update(getSalt());
        this.password = md.digest(password.getBytes(StandardCharsets.UTF_8));
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

}


