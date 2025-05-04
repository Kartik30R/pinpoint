package com.nxquar.pinpoint.service;

import org.springframework.stereotype.Service;

@Service
public interface EmailService {

    public void sendEmail(String to, String subject, String body);
    public void sendOtpEmail(String to, String otp) ;

}
