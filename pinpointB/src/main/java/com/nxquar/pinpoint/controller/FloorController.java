package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.Model.Floor;
import com.nxquar.pinpoint.service.FloorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/floors")
public class FloorController {

    @Autowired
    private FloorService floorService;

    @GetMapping("/{floorId}")
    public Floor getFloorById(@PathVariable UUID floorId) {
        return floorService.getFloorById(floorId);
    }

    @GetMapping("/building/{buildingId}")
    public List<Floor> getFloorsByBuilding(@PathVariable UUID buildingId) {
        return floorService.getFloorsByBuilding(buildingId);
    }
}
