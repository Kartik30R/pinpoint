package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.Model.Building;

import java.util.List;
import java.util.UUID;

public interface BuildingService {

    Building getBuildingById(UUID id, String jwt);

    List<Building> getBuildingsByInstitute(UUID instituteId, String jwt);

}
