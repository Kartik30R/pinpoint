package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Timetable.Attendance;
import com.nxquar.pinpoint.Model.Timetable.Period;
import com.nxquar.pinpoint.Model.Users.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalTime;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, UUID> {

    Optional<Attendance> findByStudentAndPeriod(User student, Period period);

    @Query(value = """
        SELECT p.* FROM period p
        JOIN day_schedule ds ON p.day_schedule_id = ds.id
        JOIN timetable t ON ds.timetable_id = t.id
        JOIN batch b ON t.batch_id = b.id
        WHERE b.id = :batchId
        AND ds.day_of_week = :dayOfWeek
        AND p.start_time <= :time
        AND p.end_time >= :time
        LIMIT 1
    """, nativeQuery = true)
    Optional<Period> findCurrentPeriodByBatch(UUID batchId, String dayOfWeek, LocalTime time);

    @Query(value = """
        SELECT EXISTS (
            SELECT 1 FROM room r
            WHERE r.id = :roomId
            AND ST_Contains(r.geometry, ST_SetSRID(ST_MakePoint(:lon, :lat), 4326))
        )
    """, nativeQuery = true)
    boolean isUserInRoom(UUID roomId, double lon, double lat);
}
