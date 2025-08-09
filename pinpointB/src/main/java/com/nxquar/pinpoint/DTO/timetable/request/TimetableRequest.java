package com.nxquar.pinpoint.DTO.timetable.request;

import lombok.Data;

import java.util.List;
import java.util.UUID;

@Data
public class TimetableRequest {
    private String name; // e.g., "BTech CSE 2024 - Main Timetable"
    private UUID batchId;
    private List<DayScheduleRequest> schedules;
}