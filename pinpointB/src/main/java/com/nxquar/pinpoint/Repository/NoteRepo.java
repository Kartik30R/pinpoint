package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Note;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;
public interface NoteRepo extends JpaRepository<Note, UUID> {
    List<Note> findAllByUserId(UUID userId);
    List<Note> findAllByAdminId(UUID adminId);
}
