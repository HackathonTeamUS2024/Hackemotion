package com.example.emotion.db_access;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<User, Long> {
    @Modifying
    @Query("UPDATE User SET token=:token where email=:email")
    void updateToken(@Param("email") String email,@Param("token") String token);
    User findByEmail(String email);
}

