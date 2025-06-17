package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.Model.Building;
import com.nxquar.pinpoint.Model.Users.Institute;
import com.nxquar.pinpoint.Repository.BuildingRepo;
import com.nxquar.pinpoint.Repository.InstituteRepo;
import com.nxquar.pinpoint.service.BuildingService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class BuildingServiceImpl implements BuildingService {

    @Autowired
    private BuildingRepo buildingRepo;

    @Autowired
    private InstituteRepo instituteRepo;


    @Override
    public Building getBuildingById(UUID id, String jwt) {
        Building building = buildingRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Building not found with ID: " + id));


        return building;
    }

    @Override
    public List<Building> getBuildingsByInstitute(UUID instituteId, String jwt) {
        Institute institute = instituteRepo.findById(instituteId)
                .orElseThrow(() -> new EntityNotFoundException("Institute not found"));

        return buildingRepo.findByInstituteId(instituteId);
    }
}
