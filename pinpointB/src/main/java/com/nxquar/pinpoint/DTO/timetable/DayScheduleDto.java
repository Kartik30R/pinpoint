package com.nxquar.pinpoint.DTO.timetable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.DayOfWeek;
import java.util.List;
import java.util.UUID;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class DayScheduleDto {
    private UUID id;
    private DayOfWeek dayOfWeek;
    private List<PeriodDto> periods;
    // Getters and setters
}
