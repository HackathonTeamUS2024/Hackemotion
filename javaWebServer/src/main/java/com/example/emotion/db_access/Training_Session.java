package com.example.emotion.db_access;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Training_Session {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private String sessionId;
    private String type;
    private Integer age;
    private String startedAt;
    private String endedAt;
    private long userId;
    private String imageCategory;

    public Training_Session() {
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }
}
