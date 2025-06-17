package com.nxquar.pinpoint.DTO;

import com.nxquar.pinpoint.Model.Timetable.Timetable;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.ManyToOne;
import lombok.Data;

import java.time.DayOfWeek;

@Data
public class DayScheduleRequest {
    @Enumerated(EnumType.STRING)
    private DayOfWeek dayOfWeek;

    @ManyToOne
    private Timetable timetable;
}
