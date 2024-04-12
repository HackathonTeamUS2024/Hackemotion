package com.example.emotion.db_access;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Training_Session_Result {
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        private long resultSessionId;
        private long resultId;
        private String answer;
        private String drawn;

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getDrawn() {
        return drawn;
    }

    public void setDrawn(String drawn) {
        this.drawn = drawn;
    }

    //        private String emotion_emotionId;
//        private String training_session_sessionId;
        private String user_userId;
//        private String resource_resourceId;
//        private String resource_emotion_emotionId;


    private String imageCategory;

    public Training_Session_Result() {
    }

    public long getResultId() {
        return resultId;
    }

    public void setResultId(long resultId) {
        this.resultId = resultId;
    }


    public String getImageCategory() {
        return imageCategory;
    }

    public void setImageCategory(String imageCategory) {
        this.imageCategory = imageCategory;
    }
}
