package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Batch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface BatchRepo extends JpaRepository<Batch, UUID> {
    List<Batch> findByInstitute_Id(UUID instituteId);
}
