package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Timetable.Period;

import java.util.List;
import java.util.UUID;

public interface PeriodService {

    Period getPeriodById(UUID id, String jwt);

    List<Period> getAllPeriods(UUID dayScheduleId, String jwt);

    Period createPeriod(Period period, String jwt);

    Period updatePeriod(Period updatedPeriod, String jwt);

    MessageResponse deletePeriod(UUID id, String jwt);
}
