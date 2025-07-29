package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Users.Admin;
import com.nxquar.pinpoint.Model.Users.Institute;
import com.nxquar.pinpoint.Model.Users.User;
import com.nxquar.pinpoint.Repository.AdminRepo;
import com.nxquar.pinpoint.Repository.InstituteRepo;
import com.nxquar.pinpoint.Repository.UserRepo;
import com.nxquar.pinpoint.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;


@Service

public class UserServiceImpl implements UserService {

    @Autowired
    UserRepo userRepo;

    @Autowired
    AdminRepo adminRepo;

    @Autowired
    InstituteRepo instituteRepo;

    @Autowired
    JwtService jwtService;

    @Override
    public List<User> getAllUser(UUID id, String jwt) {
        try {
            String jwtEmail = jwtService.extractUserName(jwt);

            Institute institute = instituteRepo.findByEmail(jwtEmail);
            if (institute != null) {
                if (institute.getId().equals(id)) {
                    return userRepo.findByInstituteId(id);
                } else {
                    throw new AccessDeniedException("You are not authorized to access users for this institute.");
                }
            }

            Admin admin = adminRepo.findByEmail(jwtEmail);
            if (admin != null) {
                if (admin.getId().equals(id)) {
                    return adminRepo.findUsersByAdminId(id);
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
    public User getUserById(UUID userId, String jwt) {
        try {
            String jwtEmail = jwtService.extractUserName(jwt);


            User user = userRepo.findByEmail(jwtEmail);
            if (user != null && user.getId().equals(userId)) {
                return userRepo.findById(userId)
                        .orElseThrow(() -> new RuntimeException("User not found."));
            }


            Admin admin = adminRepo.findByEmail(jwtEmail);
            if (admin != null) {
                User found = adminRepo.findUserByIdAndAdminId(userId, admin.getId());
                if (found != null) return found;
            }


            Institute institute = instituteRepo.findByEmail(jwtEmail);
            if (institute != null) {
                User found = instituteRepo.findUserByIdAndInstituteId(userId, institute.getId());
                if (found != null) return found;
            }

            // If no valid access path
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
    public MessageResponse UpdateUser(UUID id, String jwt, User updatedData) {
        String jwtEmail = jwtService.extractUserName(jwt);
        User user = userRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found."));

        boolean authorized = false;

        // Check if request is from the same user
        if (user.getEmail().equals(jwtEmail)) {
            authorized = true;
        }

        // Check if request is from the user's admin
        Admin admin = adminRepo.findByEmail(jwtEmail);
        if (admin != null && user.getAdmin() != null && admin.getId().equals(user.getAdmin().getId())) {
            authorized = true;
        }

        // Check if request is from the user's institute
        Institute institute = instituteRepo.findByEmail(jwtEmail);
        if (institute != null && user.getInstitute() != null && institute.getId().equals(user.getInstitute().getId())) {
            authorized = true;
        }

        if (!authorized) {
            throw new AccessDeniedException("You are not authorized to update this user.");
        }

        // Do your updates — update fields that are safe
        user.setName(updatedData.getName());
        user.setPhone(updatedData.getPhone());
        user.setAddress(updatedData.getAddress());
        user.setBatch(updatedData.getBatch());

        userRepo.save(user);

        return new MessageResponse("User updated successfully.");
    }

}
