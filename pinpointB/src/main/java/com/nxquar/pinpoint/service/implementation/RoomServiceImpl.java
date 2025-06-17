package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.Model.Room;
import com.nxquar.pinpoint.Repository.RoomRepo;
import com.nxquar.pinpoint.service.RoomService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class RoomServiceImpl implements RoomService {
@Autowired
    private  RoomRepo roomRepo;
@Autowired
    private  JwtService jwtService;

    @Override
    public Room getRoomById(UUID id, String jwt) {
        Room room = roomRepo.findById(id).orElseThrow(() -> new EntityNotFoundException("Room not found"));
        return room;
    }

    @Override
    public List<Room> getRoomsByFloor(Integer level, String jwt) {
        String email = jwtService.extractUserName(jwt);
        return roomRepo.findByFloorLevel(level);
    }

    @Override
    public List<Room> getRoomsByBuilding(UUID buildingId, String jwt) {
        String email = jwtService.extractUserName(jwt);
        return roomRepo.findRoomsByBuilding(buildingId);
    }

    @Override
    public List<Room> getRoomsByInstitute(UUID instituteId, String jwt) {
        String email = jwtService.extractUserName(jwt);
        return roomRepo.findRoomsByInstitute(instituteId);
    }
}
