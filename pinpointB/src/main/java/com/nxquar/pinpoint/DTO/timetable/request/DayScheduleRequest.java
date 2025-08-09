package com.nxquar.pinpoint.DTO.timetable.request;

import lombok.Data;

import java.util.List;

@Data
class DayScheduleRequest {
    private String day; // e.g., "Monday", "Tuesday"
    private List<PeriodRequest> periods;
}