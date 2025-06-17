package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface RoomRepo extends JpaRepository<Room, UUID> {
    @Query("""
    SELECT r FROM Room r 
    WHERE r.floor.building.id = :buildingId 
""")
    List<Room> findRoomsByBuilding(@Param("buildingId") UUID buildingId);
    @Query("""
    SELECT r FROM Room r 
    WHERE r.floor.building.institute.id = :instituteId
""")
    List<Room> findRoomsByInstitute(@Param("instituteId") UUID instituteId);
    List<Room> findByFloorLevel(Integer level);

}
