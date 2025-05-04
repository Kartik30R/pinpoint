package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.DTO.AuthRequest;
import com.nxquar.pinpoint.service.implementation.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody AuthRequest req) {
        return ResponseEntity.ok(authService.login(req));
    }


    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody AuthRequest req) {
        return ResponseEntity.ok(authService.register(req));
    }

//
//
//    @PostMapping("/send-otp")
//    public ResponseEntity<?> sendOtp(@RequestBody OtpRequest req) {
//        return authService.sendOtp(req);
//    }
//
//    @PostMapping("/verify-otp")
//    public ResponseEntity<?> verifyOtp(@RequestBody OtpVerificationRequest req) {
//        return authService.verifyOtp(req);
//    }
//
//
//    @PostMapping("/forgot-password")
//    public ResponseEntity<?> forgotPassword(@RequestParam String email) {
//        return authService.sendForgotPasswordOtp(email);
//    }
//
//    @PostMapping("/reset-password")
//    public ResponseEntity<?> resetPassword(@RequestBody PasswordResetRequest req) {
//        return authService.resetPassword(req);
//    }
}
