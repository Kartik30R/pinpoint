package com.nxquar.pinpoint.DTO.timetable;

import com.nxquar.pinpoint.Model.Room;
import com.nxquar.pinpoint.Model.Timetable.DaySchedule;
import com.nxquar.pinpoint.Model.Timetable.Period;
import com.nxquar.pinpoint.Model.Timetable.Subject;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalTime;
import java.util.UUID;

@Data
@AllArgsConstructor
public class PeriodDto {
    private UUID id;
    private int periodNumber;
    private String name;
    private LocalTime startTime;
    private LocalTime endTime;
    private String subjectName;
    private UUID subjectId;
    private String roomName;
    private UUID roomId;
    private UUID scheduleDayId;

    // Getters and setters

    public static PeriodDto fromEntity(Period p) {
        return new PeriodDto(
                p.getId(),
                p.getPeriodNumber(),
                p.getName(),
                p.getStartTime(),
                p.getEndTime(),
                p.getSubject().getName(),
                p.getSubject().getId(),
                p.getSite().getName(),
                p.getSite().getId(),
                p.getDaySchedule().getId()
        );
    }

    public Period toEntity(Subject subject, Room room, DaySchedule schedule) {
        Period period = new Period();
        period.setId(this.id);
        period.setPeriodNumber(this.periodNumber);
        period.setName(this.name);
        period.setStartTime(this.startTime);
        period.setEndTime(this.endTime);
        period.setSubject(subject);
        period.setSite(room);
        period.setDaySchedule(schedule);
        return period;
    }


}

