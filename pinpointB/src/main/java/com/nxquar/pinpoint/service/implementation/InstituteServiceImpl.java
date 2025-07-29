package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.InstituteRequest;
import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.branch.InstituteResponse;
import com.nxquar.pinpoint.Model.Users.Institute;
import com.nxquar.pinpoint.Repository.AdminRepo;
import com.nxquar.pinpoint.Repository.InstituteRepo;
import com.nxquar.pinpoint.Repository.UserRepo;
import com.nxquar.pinpoint.service.InstituteService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class InstituteServiceImpl implements InstituteService {

    @Autowired private AdminRepo adminRepo;
    @Autowired private UserRepo userRepo;
    @Autowired private InstituteRepo instituteRepo;
    @Autowired private JwtService jwtService;

    @Override
    public InstituteResponse getInstituteById(UUID id, String jwt) {
        String jwtEmail = jwtService.extractUserName(jwt);
        Institute institute = instituteRepo.findByEmail(jwtEmail);

        if (institute == null) {
            throw new EntityNotFoundException("Institute not found for email: " + jwtEmail);
        }

        return mapToResponse(institute);
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
        if (request.getBaseAltitude() != null) currentInstitute.setBaseAltitude(request.getBaseAltitude());

        instituteRepo.save(currentInstitute);
        return new MessageResponse("Institute updated successfully");
    }

    @Override
    public MessageResponse deleteInstitute(String jwt) {
        String jwtEmail = jwtService.extractUserName(jwt);
        Institute institute = instituteRepo.findByEmail(jwtEmail);

        adminRepo.updateInstituteToNullForAdmins(institute.getId());
        userRepo.updateInstituteToNullForUsers(institute.getId());
        instituteRepo.deleteById(institute.getId());

        return new MessageResponse("Institute deleted!");
    }

    private InstituteResponse mapToResponse(Institute institute) {
        return InstituteResponse.builder()
                .id(institute.getId().toString())
                .email(institute.getEmail())
                .phone(institute.getPhone())
                .name(institute.getName())
                .geoJsonUrl(institute.getGeoJsonUrl())
                .address(institute.getAddress())
                .createdAt(institute.getCreatedAt().toString())
                .updatedAt(institute.getUpdatedAt().toString())
                .isVerified(institute.isVerified())
                .baseAltitude(institute.getBaseAltitude())
                .build();
    }
}
