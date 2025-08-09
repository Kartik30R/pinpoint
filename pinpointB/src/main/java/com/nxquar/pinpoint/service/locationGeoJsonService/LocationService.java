package com.nxquar.pinpoint.service.locationGeoJsonService;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.LocationPoint;
import com.nxquar.pinpoint.Model.Timetable.Attendance;
import com.nxquar.pinpoint.Model.Timetable.Period;
import com.nxquar.pinpoint.Model.Timetable.Status;
import com.nxquar.pinpoint.Model.Users.User;
import com.nxquar.pinpoint.Repository.*;
import com.nxquar.pinpoint.service.implementation.JwtService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;


@Service

public class LocationService {
    @Autowired
    AdminRepo adminRepo;
    @Autowired
    UserRepo userRepo;
    @Autowired
    InstituteRepo instituteRepo;
    @Autowired
    private AttendanceRepo attendanceRepo;


    @Autowired
    JwtService jwtService;

    @Autowired
    private LocationPointRepo locationPointRepo;


    public MessageResponse saveLocation(LocationPoint point) {
        locationPointRepo.save(point);

        User student = point.getUser();
        UUID batchId = student.getBatch().getId();
        String dayOfWeek = point.getTimestamp().getDayOfWeek().name();
        LocalTime currentTime = point.getTimestamp().toLocalTime();

        Optional<Period> maybePeriod = attendanceRepo.findCurrentPeriodByBatch(batchId, dayOfWeek, currentTime);

        if (maybePeriod.isEmpty()) {
            return new MessageResponse("Location saved, but no ongoing period found.");
        }

        Period currentPeriod = maybePeriod.get();

        boolean isInRoom = attendanceRepo.isUserInRoom(
                currentPeriod.getSite().getId(),
                point.getLongitude(),
                point.getLatitude()
        );

        if (!isInRoom) {
            return new MessageResponse("Location saved, but user is not inside the room for the current period.");
        }

        boolean alreadyMarked = attendanceRepo.findByStudentAndPeriod(student, currentPeriod).isPresent();

        if (alreadyMarked) {
            return new MessageResponse("Location saved. Attendance already marked.");
        }

        Attendance attendance = new Attendance();
        attendance.setStudent(student);
        attendance.setPeriod(currentPeriod);
        attendance.setMarkedAt(point.getTimestamp());
        attendance.setStatus(Status.PRESENT);

        attendanceRepo.save(attendance);

        return new MessageResponse("Location and attendance saved successfully.");
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

