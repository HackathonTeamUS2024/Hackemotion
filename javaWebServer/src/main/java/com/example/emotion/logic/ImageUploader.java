package com.example.emotion.logic;

import org.springframework.http.*;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;

import java.io.File;

public class ImageUploader {

    private RestTemplate restTemplate = new RestTemplate();

    public ResponseEntity<String> uploadImage(File imageFile, String apiUrl) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        Resource resource = new FileSystemResource(imageFile);
        body.add("image", resource);

        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

        return restTemplate.exchange(apiUrl, HttpMethod.POST, requestEntity, String.class);
    }
}