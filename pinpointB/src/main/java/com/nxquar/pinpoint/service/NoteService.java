package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Note;
import org.aspectj.weaver.ast.Not;

import java.util.UUID;

public interface NoteService {

   public Note createNote(Note note);
   public MessageResponse UpdateNote(Note note);
   public  MessageResponse DeleteNote(UUID note);

}
