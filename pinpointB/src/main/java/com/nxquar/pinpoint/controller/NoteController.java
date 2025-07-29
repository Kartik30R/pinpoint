package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Note;
import com.nxquar.pinpoint.service.NoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/notes")
public class NoteController {

    @Autowired
    private NoteService noteService;

    @PostMapping
    public ResponseEntity<Note> createNote(@RequestBody Note note,
                                           @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(noteService.createNote(note, token));
    }

    @PutMapping
    public ResponseEntity<MessageResponse> updateNote(@RequestBody Note note,
                                                      @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(noteService.UpdateNote(note, token));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<MessageResponse> deleteNote(@PathVariable UUID id,
                                                      @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(noteService.DeleteNote(id, token));
    }

    @GetMapping
    public ResponseEntity<List<Note>> getAllNotes(@RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(noteService.getAllNotes(token));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Note> getNoteById(@PathVariable UUID id,
                                            @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(noteService.getNoteById(id, token));
    }
}
