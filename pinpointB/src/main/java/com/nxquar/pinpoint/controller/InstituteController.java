package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.DTO.InstituteRequest;
import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.branch.InstituteResponse;
import com.nxquar.pinpoint.service.InstituteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/institute")
public class InstituteController {

    @Autowired
    private InstituteService instituteService;

    @GetMapping
    public ResponseEntity<InstituteResponse> getInstitute(@RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(instituteService.getInstituteById(null, token));
    }

    @PutMapping
    public ResponseEntity<MessageResponse> updateInstitute(@RequestBody InstituteRequest request,
                                                           @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(instituteService.updateInstitute(request, token));
    }

    @DeleteMapping
    public ResponseEntity<MessageResponse> deleteInstitute(@RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(instituteService.deleteInstitute(token));
    }
}
