package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Note;
import org.aspectj.weaver.ast.Not;

import java.util.List;
import java.util.UUID;

public interface NoteService {
   Note createNote(Note note, String jwt);
   MessageResponse UpdateNote(Note note, String jwt);
   MessageResponse DeleteNote(UUID noteId, String jwt);
   List<Note> getAllNotes(String jwt);
   Note getNoteById(UUID id, String jwt);

}
