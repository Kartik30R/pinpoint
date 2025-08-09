package com.nxquar.pinpoint.DTO.timetable;

import com.nxquar.pinpoint.Model.Timetable.Timetable;
import lombok.Data;

import java.util.List;
import java.util.UUID;

@Data
public class TimetableDetailDto {
    private UUID id;
    private String name;
    private List<DayScheduleDto> daySchedules;

    public static TimetableDetailDto fromEntity(Timetable timetable) {
        List<DayScheduleDto> scheduleDtos = timetable.getDaySchedules().stream()
                .map(day -> new DayScheduleDto(
                        day.getId(),
                        day.getDayOfWeek(),
                        day.getPeriods().stream()
                                .map(PeriodDto::fromEntity)
                                .toList()
                ))
                .toList();

        TimetableDetailDto dto = new TimetableDetailDto();
        dto.setId(timetable.getId());
        dto.setName(timetable.getName());
        dto.setDaySchedules(scheduleDtos);
        return dto;
    }
}
