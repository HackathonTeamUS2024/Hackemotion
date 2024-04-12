package com.example.emotion.db_access;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Resource {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private long resourceId;
    private String path;
    private String type;
    private Integer age;
    private String sex;
    private String imageCategory;
    private String emotion_emotionId;

//    public String getEmotion_emotionId() {
//        return emotion_emotionId;
//    }
//
//    public void setEmotion_emotionId(String emotion_emotionId) {
//        this.emotion_emotionId = emotion_emotionId;
//    }

    public long getResourceId() {
        return resourceId;
    }

    public void setResourceId(long resourceId) {
        this.resourceId = resourceId;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getImageCategory() {
        return imageCategory;
    }

    public void setImageCategory(String imageCategory) {
        this.imageCategory = imageCategory;
    }
}
