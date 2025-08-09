package com.nxquar.pinpoint.DTO.timetable;

import lombok.Data;

import java.util.UUID;


@Data
public class TimetableSummaryDto {
    private UUID id;
    private String name;
    private UUID batchId;
    private String batchName;
}