package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Timetable.Period;
import com.nxquar.pinpoint.Repository.PeriodRepo;
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
    private  JwtService jwtService;

    @Override
    public Period getPeriodById(UUID id, String jwt) {
        Period period = periodRepo.findById(id)
                .orElseThrow(
                        () -> new EntityNotFoundException("Period with this id does not Exist:" + id.toString()));
        return period;
    }

    @Override
    public List<Period> getAllPeriods(UUID dayScheduleId, String jwt) {
        List<Period> periodList= periodRepo.findByDayScheduleId(dayScheduleId);
        return periodList;
    }

    @Override
    public Period createPeriod(Period period, String jwt) {
        String role = jwtService.extractRole(jwt);
        boolean isInstitute =  role.equals("INSTITUTE");
        boolean isAdmin =  role.equals("ADMIN");

        if(!(isInstitute || isAdmin)) {
            throw new AccessDeniedException("You are not authorized to create this Period");
        }
        return periodRepo.save(period);
    }

    @Override
    public Period updatePeriod(Period updatedPeriod, String jwt) {
        Period existingPeriod= periodRepo.findById(updatedPeriod.getId()).orElseThrow(
                ()->new EntityNotFoundException("Period with this Id does not exist:"+ updatedPeriod.getId()
        ));

        String role = jwtService.extractRole(jwt);
        boolean isInstitute =  role.equals("INSTITUTE");
        boolean isAdmin =  role.equals("ADMIN");

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

        if (updatedPeriod.getSubject() != null)
            existingPeriod.setSubject(updatedPeriod.getSubject());

        if (updatedPeriod.getSite() != null)
            existingPeriod.setSite(updatedPeriod.getSite());

        return periodRepo.save(existingPeriod);
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
