package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.LocationPoint;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public interface LocationPointRepo  extends JpaRepository<LocationPoint, UUID> {
    List<LocationPoint> findByUserId(UUID id);
    List<LocationPoint> findByUserIdAndTimestampBetween(UUID userId, LocalDateTime start, LocalDateTime end);

}
