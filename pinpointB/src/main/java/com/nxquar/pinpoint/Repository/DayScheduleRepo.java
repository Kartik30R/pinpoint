package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Timetable.DaySchedule;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface DayScheduleRepo  extends JpaRepository<DaySchedule, UUID> {
}
