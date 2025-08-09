package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.UpdateUserDto;
import com.nxquar.pinpoint.DTO.UserDetailDto;
import com.nxquar.pinpoint.DTO.UserListDto;
import com.nxquar.pinpoint.Model.Batch;
import com.nxquar.pinpoint.Model.Users.Admin;
import com.nxquar.pinpoint.Model.Users.Institute;
import com.nxquar.pinpoint.Model.Users.User;
import com.nxquar.pinpoint.Repository.AdminRepo;
import com.nxquar.pinpoint.Repository.BatchRepo;
import com.nxquar.pinpoint.Repository.InstituteRepo;
import com.nxquar.pinpoint.Repository.UserRepo;
import com.nxquar.pinpoint.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;


@Service

public class UserServiceImpl implements UserService {

    @Autowired
    UserRepo userRepo;

    @Autowired
    AdminRepo adminRepo;

    @Autowired
    BatchRepo batchRepo;


    @Autowired
    InstituteRepo instituteRepo;

    @Autowired
    JwtService jwtService;

    @Override
    public List<UserListDto> getAllUser(UUID id, String jwt) {
        try {
            String jwtEmail = jwtService.extractUserName(jwt);

            Institute institute = instituteRepo.findByEmail(jwtEmail);
            if (institute != null) {
                if (institute.getId().equals(id)) {
                    return userRepo.findByInstituteId(id)
                            .stream()
                            .map(UserListDto::fromEntity)
                            .collect(Collectors.toList());

                } else {
                    throw new AccessDeniedException("You are not authorized to access users for this institute.");
                }
            }

            Admin admin = adminRepo.findByEmail(jwtEmail);
            if (admin != null) {
                if (admin.getId().equals(id)) {
                    return adminRepo.findUsersByAdminId(id)
                            .stream()
                            .map(UserListDto::fromEntity)
                            .collect(Collectors.toList());
                } else {
                    throw new AccessDeniedException("You are not authorized to access users for this admin.");
                }
            }


            throw new AccessDeniedException("Invalid JWT or unauthorized access.");
        } catch (AccessDeniedException ade) {
            throw ade; // Let Spring Security or controller advice handle 403
        } catch (Exception e) {
            throw new RuntimeException("Error occurred while fetching users.", e);
        }
    }


    @Override
    public UserDetailDto getUserById(UUID userId, String jwt) {
        try {
            String jwtEmail = jwtService.extractUserName(jwt);

            // 1. Check if the user is accessing their own data
            User user = userRepo.findByEmail(jwtEmail);
            if (user != null && user.getId().equals(userId)) {
                return UserDetailDto.fromEntity(user);
            }

            // 2. Check if an admin has access to the user
            Admin admin = adminRepo.findByEmail(jwtEmail);
            if (admin != null) {
                User found = adminRepo.findUserByIdAndAdminId(userId, admin.getId());
                if (found != null) return UserDetailDto.fromEntity(found);
            }

            // 3. Check if institute has access
            Institute institute = instituteRepo.findByEmail(jwtEmail);
            if (institute != null) {
                User found = instituteRepo.findUserByIdAndInstituteId(userId, institute.getId());
                if (found != null) return UserDetailDto.fromEntity(found);
            }

            // 4. Deny if none match
            throw new AccessDeniedException("You are not authorized to access this user.");
        } catch (AccessDeniedException ade) {
            throw ade;
        } catch (Exception e) {
            throw new RuntimeException("Error while fetching user.", e);
        }
    }

    @Override
    public MessageResponse deleteUser(UUID userId, String jwt) {
        try {
            String jwtEmail = jwtService.extractUserName(jwt);
            Institute institute = instituteRepo.findByEmail(jwtEmail);

            if (institute == null) {
                throw new AccessDeniedException("Only institutes can delete users.");
            }

            User user = userRepo.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found."));

            if (!user.getInstitute().getId().equals(institute.getId())) {
                throw new AccessDeniedException("You are not authorized to delete this user.");
            }

            userRepo.deleteById(userId);
            return new MessageResponse("User deleted successfully.");
        } catch (AccessDeniedException ade) {
            throw ade;
        } catch (Exception e) {
            throw new RuntimeException("Error while deleting user.", e);
        }
    }


    @Override
    public MessageResponse UpdateUser(UUID id, String jwt, UpdateUserDto updatedData) {
        String jwtEmail = jwtService.extractUserName(jwt);
        User user = userRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found."));

        boolean authorized = false;

        if (user.getEmail().equals(jwtEmail)) authorized = true;

        Admin admin = adminRepo.findByEmail(jwtEmail);
        if (admin != null && user.getAdmin() != null && admin.getId().equals(user.getAdmin().getId()))
            authorized = true;

        Institute institute = instituteRepo.findByEmail(jwtEmail);
        if (institute != null && user.getInstitute() != null && institute.getId().equals(user.getInstitute().getId()))
            authorized = true;

        if (!authorized) {
            throw new AccessDeniedException("You are not authorized to update this user.");
        }

        // Safe field updates
        user.setName(updatedData.getName());
        user.setPhone(updatedData.getPhone());
        user.setAddress(updatedData.getAddress());
        user.setVerified(updatedData.isVerified());

        if (updatedData.getBatchId() != null) {
            Batch batch = batchRepo.findById(updatedData.getBatchId())
                    .orElseThrow(() -> new RuntimeException("Batch not found."));
            user.setBatch(batch);
        }

        if (updatedData.getAdminId() != null) {
            Admin newAdmin = adminRepo.findById(updatedData.getAdminId())
                    .orElseThrow(() -> new RuntimeException("Admin not found."));
            user.setAdmin(newAdmin);
        }

        userRepo.save(user);

        return new MessageResponse("User updated successfully.");
    }

}
