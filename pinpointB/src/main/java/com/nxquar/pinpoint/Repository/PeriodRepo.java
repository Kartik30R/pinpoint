package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Timetable.Period;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface PeriodRepo extends JpaRepository<Period, UUID> {
List<Period> findByDayScheduleId(UUID id );
}
