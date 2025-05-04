//package com.nxquar.pinpoint.service.implementation;
//
//import com.nxquar.pinpoint.service.EmailService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.mail.SimpleMailMessage;
//import org.springframework.mail.javamail.JavaMailSender;
//import org.springframework.stereotype.Service;
//
//@Service
//public class EmailServiceImpl implements EmailService {
//
//    @Autowired
//    private JavaMailSender mailSender;
//
//    public void sendEmail(String to, String subject, String body) {
//        SimpleMailMessage message = new SimpleMailMessage();
//        message.setFrom("your-brevo-email@example.com");
//        message.setTo(to);
//        message.setSubject(subject);
//        message.setText(body);
//        mailSender.send(message);
//    }
//    public void sendOtpEmail(String to, String otp) {
//        String body = "Your OTP is: " + otp + "\nIt expires in 5 minutes.";
//        sendEmail(to, "Your OTP Code", body); // Using Brevo SMTP config
//    }
//
//}