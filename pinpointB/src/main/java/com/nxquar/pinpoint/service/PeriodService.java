package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.timetable.PeriodDto;
import com.nxquar.pinpoint.Model.Timetable.Period;

import java.util.List;
import java.util.UUID;

public interface PeriodService {

    PeriodDto getPeriodById(UUID id, String jwt);

    List<Period> getAllPeriods(UUID dayScheduleId, String jwt);

    PeriodDto createPeriod(PeriodDto period, String jwt);

    PeriodDto updatePeriod(PeriodDto updatedPeriod, String jwt);

    MessageResponse deletePeriod(UUID id, String jwt);
}
