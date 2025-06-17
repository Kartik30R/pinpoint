package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Building;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface BuildingRepo extends JpaRepository<Building, UUID> {
    List<Building> findByInstituteId(UUID id);
}
