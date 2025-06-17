package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Timetable.Subject;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.UUID;

public interface SubjectService {

    Subject getSubjectById(UUID id, String jwt);

    List<Subject> getAllSubjectsByInstitute(UUID instituteId, String jwt);

    Subject createSubject(Subject subject, String jwt);

    Subject updateSubject(Subject updatedSubject, String jwt);

    MessageResponse deleteSubject(UUID id, String jwt);
}
