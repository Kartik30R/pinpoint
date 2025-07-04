package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.DayScheduleRequest;
import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Timetable.DaySchedule;

import java.util.List;
import java.util.UUID;

public interface ScheduleService {
    DaySchedule createSchedule(DayScheduleRequest schedule, String jwt);

    DaySchedule getScheduleById(UUID id, String jwt);

    List<DaySchedule> getSchedulesByTimetableId(UUID timetableId, String jwt);

    DaySchedule addDaySchedule(UUID timetableId, DaySchedule newSchedule);

    DaySchedule updateSchedule(DaySchedule updatedSchedule, String jwt);

    MessageResponse deleteSchedule(UUID id, String jwt);
}
