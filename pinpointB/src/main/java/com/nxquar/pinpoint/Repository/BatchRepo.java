package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Batch;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface BatchRepo extends JpaRepository<Batch, UUID> {

}
