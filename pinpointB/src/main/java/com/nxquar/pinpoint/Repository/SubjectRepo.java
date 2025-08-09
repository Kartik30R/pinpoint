package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Timetable.Subject;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface SubjectRepo extends JpaRepository<Subject, UUID> {
    List<Subject> findByInstituteId(UUID id);
Subject findByName(String name);
}
