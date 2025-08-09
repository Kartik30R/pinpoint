package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.TimetableRequest;
import com.nxquar.pinpoint.DTO.timetable.TimetableDetailDto;
import com.nxquar.pinpoint.Model.Batch;
import com.nxquar.pinpoint.Model.Timetable.Timetable;
import com.nxquar.pinpoint.Repository.BatchRepo;
import com.nxquar.pinpoint.Repository.InstituteRepo;
import com.nxquar.pinpoint.Repository.TimeTableRepo;
import com.nxquar.pinpoint.service.TimetableServices;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class TimetableServicesImpl implements TimetableServices {

    @Autowired
    private BatchRepo batchRepo;

    @Autowired
    private TimeTableRepo timeTableRepo;

    @Autowired
    private InstituteRepo instituteRepo;

    @Autowired
    private JwtService jwtService;

    @Override
    public TimetableDetailDto getTimeTableById(UUID id) {
        Timetable timetable = timeTableRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Timetable not found with ID: " + id));

        return TimetableDetailDto.fromEntity(timetable);
    }

    @Override
    public List<Timetable> getTimeTable(String jwt) {
        String jwtEmail = jwtService.extractUserName(jwt);
        return timeTableRepo.findByInstituteEmail(jwtEmail);
    }

    @Override
    public Timetable createTimeTable(TimetableRequest dto, String jwt) {
        return batchRepo.findById(dto.getBatchId())
                .map(batch -> {
                    Timetable timetable = new Timetable();
                    timetable.setName(dto.getName());
                    timetable.setBatch(batch);
                    return timeTableRepo.save(timetable);
                })
                .orElseThrow(() -> new RuntimeException("Batch not found"));
    }

    @Override
    public Timetable updateTimeTable(TimetableRequest updatedTimeTable, String jwt) {
        Timetable timetable = timeTableRepo.findById(updatedTimeTable.getId())
                .orElseThrow(() -> new EntityNotFoundException("Timetable not found"));

        if (updatedTimeTable.getName() != null) {
            timetable.setName(updatedTimeTable.getName());
        }

        if (updatedTimeTable.getBatchId() != null) {
            Batch batch = batchRepo.findById(updatedTimeTable.getBatchId())
                    .orElseThrow(() -> new EntityNotFoundException("Batch not found"));
            timetable.setBatch(batch);
        }

        return timeTableRepo.save(timetable);
    }

    @Override
    public MessageResponse deleteTimeTable(UUID id, String jwt) {
        Optional<Timetable> timetable = timeTableRepo.findById(id);

        if (timetable.isEmpty()) {
            return new MessageResponse("Timetable not found");
        }

        timeTableRepo.deleteById(id);
        return new MessageResponse("Timetable deleted");
    }
}
