package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.TimetableRequest;
import com.nxquar.pinpoint.DTO.timetable.TimetableDetailDto;
import com.nxquar.pinpoint.Model.Timetable.Timetable;

import java.util.List;
import java.util.UUID;

public interface TimetableServices {
    TimetableDetailDto getTimeTableById(UUID id);
    List<Timetable> getTimeTable(String jwt);
    Timetable createTimeTable(TimetableRequest timetable, String jwt);
    Timetable updateTimeTable(TimetableRequest updatedTimeTable, String jwt);
    MessageResponse deleteTimeTable(UUID id, String jwt);

}
