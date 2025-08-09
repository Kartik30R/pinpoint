package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.timetable.PeriodDto;
import com.nxquar.pinpoint.Model.Room;
import com.nxquar.pinpoint.Model.Timetable.DaySchedule;
import com.nxquar.pinpoint.Model.Timetable.Period;
import com.nxquar.pinpoint.Model.Timetable.Subject;
import com.nxquar.pinpoint.Repository.DayScheduleRepo;
import com.nxquar.pinpoint.Repository.PeriodRepo;
import com.nxquar.pinpoint.Repository.RoomRepo;
import com.nxquar.pinpoint.Repository.SubjectRepo;
import com.nxquar.pinpoint.service.PeriodService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;



@Service

public class PeriodServiceImpl implements PeriodService {
    @Autowired
    private PeriodRepo periodRepo;

    @Autowired
    private SubjectRepo subjectRepo;

    @Autowired
    private RoomRepo roomRepo;
    @Autowired
    private DayScheduleRepo dayScheduleRepo;


    @Autowired
    private  JwtService jwtService;



    @Override
    public PeriodDto getPeriodById(UUID id, String jwt) {
        Period period = periodRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Period with this id does not exist: " + id));
        return PeriodDto.fromEntity(period);
    }

    @Override
    public List<Period> getAllPeriods(UUID dayScheduleId, String jwt) {
        return List.of();
    }

    @Override
    public PeriodDto createPeriod(PeriodDto dto, String jwt) {
        String role = jwtService.extractRole(jwt);
        if (!(role.equals("INSTITUTE") || role.equals("ADMIN"))) {
            throw new AccessDeniedException("You are not authorized to create this Period");
        }

        Subject subject = subjectRepo.findById(dto.getSubjectId()).orElseThrow();

        Room room = roomRepo.findById(dto.getRoomId())
                .orElseThrow(() -> new EntityNotFoundException("Room not found"));
         DaySchedule schedule = dayScheduleRepo.findById(dto.getScheduleDayId()).orElseThrow();

        Period saved = periodRepo.save(dto.toEntity(subject, room, schedule));
        return PeriodDto.fromEntity(saved);
    }


    @Override
    public PeriodDto updatePeriod(PeriodDto updatedPeriod, String jwt) {
        Period existingPeriod= periodRepo.findById(updatedPeriod.getId()).orElseThrow(
                ()->new EntityNotFoundException("Period with this Id does not exist:"+ updatedPeriod.getId()
        ));

        String role = jwtService.extractRole(jwt);
        boolean isInstitute =  role.equals("INSTITUTE");
        boolean isAdmin =  role.equals("ADMIN");

        Subject subject= new Subject();
        if(!(isInstitute || isAdmin)) {
            throw new AccessDeniedException("You are not authorized to update this Period");
        }

        if (updatedPeriod.getPeriodNumber() != 0)
            existingPeriod.setPeriodNumber(updatedPeriod.getPeriodNumber());

        if (updatedPeriod.getName() != null)
            existingPeriod.setName(updatedPeriod.getName());

        if (updatedPeriod.getStartTime() != null)
            existingPeriod.setStartTime(updatedPeriod.getStartTime());

        if (updatedPeriod.getEndTime() != null)
            existingPeriod.setEndTime(updatedPeriod.getEndTime());

        if (updatedPeriod.getSubjectName() != null) {
            subject = subjectRepo.findByName(updatedPeriod.getName());
            existingPeriod.setSubject(subject);
        }
        if (updatedPeriod.getRoomName() != null) {
            Room room = roomRepo.findByName(updatedPeriod.getRoomName());
            existingPeriod.setSite(room);
        }

        return PeriodDto.fromEntity(periodRepo.save(existingPeriod));
    }

    @Override
    public MessageResponse deletePeriod(UUID id, String jwt) {
        Period existingPeriod= periodRepo.findById(id).orElseThrow(
                ()->new EntityNotFoundException("Period with this Id does not exist:"+id
                ));

        String role = jwtService.extractRole(jwt);
        boolean isInstitute =  role.equals("INSTITUTE");
        boolean isAdmin =  role.equals("ADMIN");

        if(!(isInstitute || isAdmin)) {
            throw new AccessDeniedException("You are not authorized to delete this Period");
        }
        periodRepo.delete(existingPeriod);

        return new MessageResponse("Period deleted");
    }
}
