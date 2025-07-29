package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.branch.BatchDetailResponse;
import com.nxquar.pinpoint.DTO.branch.BatchListResponse;
import com.nxquar.pinpoint.Model.Batch;

import java.util.List;
import java.util.UUID;

import com.nxquar.pinpoint.DTO.*;

import java.util.List;
import java.util.UUID;

public interface BatchService {
    Batch createBatch(Batch batch, String jwt);
    Batch updateBatch(UUID id, Batch batch, String jwt);
    MessageResponse deleteBatch(UUID id, String jwt);
    BatchDetailResponse getBatchDetailsById(UUID id);
    List<BatchListResponse> getAllBatchSummaries(String jwt);
}
