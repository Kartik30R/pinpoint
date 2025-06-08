package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Floor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface FloorRepository extends JpaRepository<Floor, UUID> {}
