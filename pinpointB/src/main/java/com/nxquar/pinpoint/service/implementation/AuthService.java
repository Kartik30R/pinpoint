package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.Model.Users.Admin;
import com.nxquar.pinpoint.Model.Users.AppUser;
import com.nxquar.pinpoint.Model.Users.Institute;
import com.nxquar.pinpoint.Model.Users.User;
import com.nxquar.pinpoint.Repository.AdminRepo;
import com.nxquar.pinpoint.Repository.InstituteRepo;
import com.nxquar.pinpoint.Repository.UserRepo;
import com.nxquar.pinpoint.constant.Role;
import com.nxquar.pinpoint.DTO.AuthRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {
    @Autowired
    private JwtService jwtService;

    PasswordEncoder encoder= new BCryptPasswordEncoder();
    @Autowired
    private AuthenticationManager authenticationManager;


    @Autowired
    private UserRepo userRepository;

    @Autowired
    private AdminRepo adminRepository;

    @Autowired
    private InstituteRepo instituteRepository;



    public AuthRequest register(AuthRequest req) {
        AuthRequest response= new AuthRequest();

        AppUser existingUser = userRepository.findByEmail(req.getEmail());
        if (existingUser == null) existingUser = adminRepository.findByEmail(req.getEmail());
        if (existingUser == null) existingUser = instituteRepository.findByEmail(req.getEmail());

        if (existingUser != null) {
            response.setMessage("Email already exists");
            response.setStatusCode("409");
            return response;
        }

        Role role = req.getRole();

        String hashedPassword = encoder.encode(req.getPassword());
        req.setPassword(hashedPassword);

        switch (role) {
            case USER -> {
                User user = new User();
                user.setEmail(req.getEmail());
                user.setPhone(req.getPhone());
                user.setPassword(req.getPassword());
                user.setRole(Role.USER);
                userRepository.save(user);
            }
            case ADMIN -> {
                Admin admin = new Admin();
                admin.setEmail(req.getEmail());
                admin.setPhone(req.getPhone());
                admin.setPassword(req.getPassword());
                admin.setRole(Role.ADMIN);
                adminRepository.save(admin);
            }
            case INSTITUTE -> {
                Institute institute = new Institute();
                institute.setEmail(req.getEmail());
                institute.setPhone(req.getPhone());
                institute.setPassword(req.getPassword());
                institute.setRole(Role.INSTITUTE);
                instituteRepository.save(institute);
            }
            default -> throw new IllegalArgumentException("Invalid role");
        }
response.setEmail(req.getEmail());
        response.setMessage("User Registered SuccessFully!");
        response.setStatusCode("200");
        return response;
    }


    public AuthRequest login(AuthRequest logInReq) {
        AuthRequest res = new AuthRequest();

        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            logInReq.getEmail(), logInReq.getPassword()
                    )
            );

            AppUser user = userRepository.findByEmail(logInReq.getEmail());
            if (user == null) user = adminRepository.findByEmail(logInReq.getEmail());
            if (user == null) user = instituteRepository.findByEmail(logInReq.getEmail());

            String jwtToken = jwtService.generateToken(user);

            res.setEmail(user.getEmail());
            res.setRole(user.getRole());
            res.setJwt(jwtToken);
            res.setStatusCode("200");

        } catch (AuthenticationException e) {
            res.setStatusCode("500");
            res.setError(e.getMessage());
        }
        return res;
    }

}