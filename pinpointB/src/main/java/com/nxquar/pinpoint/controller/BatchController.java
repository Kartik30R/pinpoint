package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.branch.BatchDetailResponse;
import com.nxquar.pinpoint.DTO.branch.BatchListResponse;
import com.nxquar.pinpoint.Model.Batch;
import com.nxquar.pinpoint.service.BatchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;



@RestController
@RequestMapping("/api/batches")
public class BatchController {

    @Autowired
    private BatchService batchService;

    @PostMapping
    public Batch createBatch(@RequestBody Batch batch, @RequestHeader("Authorization") String authHeader) {
        String jwt = extractToken(authHeader);
        return batchService.createBatch(batch, jwt);
    }

    @GetMapping
    public List<BatchListResponse> getAllBatches(@RequestHeader("Authorization") String authHeader) {
        String jwt = extractToken(authHeader);
        return batchService.getAllBatchSummaries(jwt);
    }

    @GetMapping("/{id}")
    public BatchDetailResponse getBatchById(@PathVariable UUID id) {
        return batchService.getBatchDetailsById(id);
    }

    @DeleteMapping("/{id}")
    public MessageResponse deleteBatch(@PathVariable UUID id, @RequestHeader("Authorization") String authHeader) {
        String jwt = extractToken(authHeader);
        return batchService.deleteBatch(id, jwt);
    }

    private String extractToken(String header) {
        return header.startsWith("Bearer ") ? header.substring(7) : header;
    }
}
