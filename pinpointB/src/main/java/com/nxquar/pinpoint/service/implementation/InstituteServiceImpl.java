package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.InstituteRequest;
import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Users.Institute;
import com.nxquar.pinpoint.Repository.AdminRepo;
import com.nxquar.pinpoint.Repository.InstituteRepo;
import com.nxquar.pinpoint.Repository.UserRepo;
import com.nxquar.pinpoint.service.InstituteService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.UUID;

public class InstituteServiceImpl implements InstituteService {
    PasswordEncoder encoder= new BCryptPasswordEncoder();
    @Autowired
    AdminRepo adminRepo;
    @Autowired
    UserRepo userRepo;
    @Autowired
    InstituteRepo instituteRepo;

    @Autowired
    JwtService jwtService;

    @Override
    public Institute getInstituteById(UUID id, String jwt) {
        String jwtEmail=jwtService.extractUserName(jwt) ;
        Institute institute=instituteRepo.findByEmail(jwtEmail);

        if(institute==null){
            throw new EntityNotFoundException("Institute not found for email: " + jwtEmail);

        }
        return institute;
    }

    @Override
    public MessageResponse updateInstitute(InstituteRequest request, String jwt) {
        String jwtEmail = jwtService.extractUserName(jwt);
        Institute currentInstitute = instituteRepo.findByEmail(jwtEmail);
        Institute targetInstitute = instituteRepo.findByEmail(request.getEmail());

        if (currentInstitute == null || !currentInstitute.getId().equals(targetInstitute.getId())) {
            throw new AccessDeniedException("You cannot update this institute's details");
        }

        if (request.getName() != null) currentInstitute.setName(request.getName());
        if (request.getPhone() != null) currentInstitute.setPhone(request.getPhone());
        if (request.getAddress() != null) currentInstitute.setAddress(request.getAddress());
//        if (request.getPassword() != null) currentInstitute.setPassword(encoder.encode(request.getPassword()));
        // optional: email update - risky unless verified
        // if (request.getEmail() != null) currentInstitute.setEmail(request.getEmail());

        instituteRepo.save(currentInstitute);
        return new MessageResponse("Institute updated successfully");
    }


    @Override
    public MessageResponse deleteInstitute( String jwt) {
        String jwtEmail= jwtService.extractUserName(jwt);
        Institute institute= instituteRepo.findByEmail(jwtEmail);
        adminRepo.updateInstituteToNullForAdmins(institute.getId());
        userRepo.updateInstituteToNullForUsers(institute.getId());
        instituteRepo.deleteById(institute.getId());

        return new MessageResponse("Institute deleted !");
    }
}
