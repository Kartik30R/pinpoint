package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Timetable.Subject;
import com.nxquar.pinpoint.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/subjects")
public class SubjectController {

    @Autowired
    private SubjectService subjectService;

    @GetMapping("/{id}")
    public ResponseEntity<Subject> getSubjectById(@PathVariable UUID id,
                                                  @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(subjectService.getSubjectById(id, token));
    }

    @GetMapping("/institute/{instituteId}")
    public ResponseEntity<List<Subject>> getAllSubjects(@PathVariable UUID instituteId,
                                                        @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(subjectService.getAllSubjectsByInstitute(instituteId, token));
    }

    @PostMapping
    public ResponseEntity<Subject> createSubject(@RequestBody Subject subject,
                                                 @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(subjectService.createSubject(subject, token));
    }

    @PutMapping
    public ResponseEntity<Subject> updateSubject(@RequestBody Subject subject,
                                                 @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(subjectService.updateSubject(subject, token));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<MessageResponse> deleteSubject(@PathVariable UUID id,
                                                         @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(subjectService.deleteSubject(id, token));
    }
}
