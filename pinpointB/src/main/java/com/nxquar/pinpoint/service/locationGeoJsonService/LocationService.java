package com.nxquar.pinpoint.service.locationGeoJsonService;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.LocationPoint;
import com.nxquar.pinpoint.Model.Users.User;
import com.nxquar.pinpoint.Repository.AdminRepo;
import com.nxquar.pinpoint.Repository.InstituteRepo;
import com.nxquar.pinpoint.Repository.LocationPointRepo;
import com.nxquar.pinpoint.Repository.UserRepo;
import com.nxquar.pinpoint.service.implementation.JwtService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;

import java.awt.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public class LocationServices {
    @Autowired
    AdminRepo adminRepo;
    @Autowired
    UserRepo userRepo;
    @Autowired
    InstituteRepo instituteRepo;

    @Autowired
    JwtService jwtService;

    @Autowired
    private LocationPointRepo locationPointRepo;


    MessageResponse saveLocation(LocationPoint point) {

// have to save the location points and also have to mark the attendence
        // first check attendce is mark or not if not then check the timetable and
        // fetch the table also get the time table from the user batch and find perid accordin to the time now and check
        // if current location is  under the period site or not
        //
        locationPointRepo.save(point);
        return new MessageResponse("location saved");
    }

    public List<LocationPoint> getLocationPoints(UUID userId, LocalDateTime start, LocalDateTime end) {
        User student = userRepo.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("Student with userId not present"));

        // default: last 1 day if not provided
        if (start == null || end == null) {
            end = LocalDateTime.now();
            start = end.minusDays(1);
        }

        return locationPointRepo.findByUserIdAndTimestampBetween(userId, start, end);
    }



    public List<LocationPoint> getUserLocation(UUID id, String jwt) {
        String email = jwtService.extractUserName(jwt);
        String role = jwtService.extractRole(jwt);

        User targetUser = userRepo.findById(id).orElseThrow(() -> new EntityNotFoundException("User not found"));

        boolean isSelf = targetUser.getEmail().equals(email);
        boolean isAdmin = adminRepo.findByEmail(email) != null;
        boolean isInstitute = instituteRepo.findByEmail(email) != null;

        if (!(isSelf || isAdmin || isInstitute)) {
            throw new AccessDeniedException("You are not authorized to view this user's location.");
        }

        return locationPointRepo.findByUserId(id);
    }


}

