package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.timetable.PeriodDto;
import com.nxquar.pinpoint.Model.Timetable.Period;
import com.nxquar.pinpoint.service.PeriodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/periods")
public class PeriodController {

    @Autowired
    private PeriodService periodService;

    @GetMapping("/{id}")
    public ResponseEntity<PeriodDto> getPeriodById(@PathVariable UUID id,
                                                   @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(periodService.getPeriodById(id, token));
    }

    @GetMapping("/schedule/{dayScheduleId}")
    public ResponseEntity<List<Period>> getAllPeriods(@PathVariable UUID dayScheduleId,
                                                      @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(periodService.getAllPeriods(dayScheduleId, token));
    }

    @PostMapping
    public ResponseEntity<PeriodDto> createPeriod(@RequestBody PeriodDto period,
                                               @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(periodService.createPeriod(period, token));
    }

    @PutMapping
    public ResponseEntity<PeriodDto> updatePeriod(@RequestBody PeriodDto updatedPeriod,
                                               @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(periodService.updatePeriod(updatedPeriod, token));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<MessageResponse> deletePeriod(@PathVariable UUID id,
                                                        @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(periodService.deletePeriod(id, token));
    }
}
