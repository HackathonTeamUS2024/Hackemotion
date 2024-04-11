package com.example.emotion.db_access;

//import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository {
    User findByEmail(String email);
}

