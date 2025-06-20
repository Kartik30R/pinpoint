package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.Model.Floor;

import java.util.List;
import java.util.UUID;

public interface FloorService {

    Floor getFloorById(UUID id, String jwt);

    List<Floor> getFloorsByBuilding(UUID buildingId, String jwt);

}
