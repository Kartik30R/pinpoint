package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.Model.Floor;
import com.nxquar.pinpoint.Repository.BuildingRepository;
import com.nxquar.pinpoint.Repository.FloorRepository;
import com.nxquar.pinpoint.service.FloorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;


@Service

public class FloorServiceImpl implements FloorService {

    @Autowired
    FloorRepository  floorRepo;

    @Autowired
    BuildingRepository buildingRepo;

    @Override
    public Floor getFloorById(UUID id) {
        return floorRepo.findById(id).orElseThrow();
    }

    @Override
    public List<Floor> getFloorsByBuilding(UUID buildingId) {
        return floorRepo.findByBuilding_Id(buildingId);
    }
}
