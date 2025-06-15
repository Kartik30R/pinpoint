package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Note;
import com.nxquar.pinpoint.Model.Users.Admin;
import com.nxquar.pinpoint.Model.Users.User;
import com.nxquar.pinpoint.Repository.AdminRepo;
import com.nxquar.pinpoint.Repository.NoteRepo;
import com.nxquar.pinpoint.Repository.UserRepo;
import com.nxquar.pinpoint.service.NoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class NoteServiceImpl implements NoteService {

    @Autowired
    private NoteRepo noteRepo;
    @Autowired private UserRepo userRepo;
    @Autowired private AdminRepo adminRepo;
    @Autowired private JwtService jwtService;

    @Override
    public Note createNote(Note note, String jwt) {
        String email = jwtService.extractUserName(jwt);
        User user = userRepo.findByEmail(email);
        if (user != null) {
            note.setUser(user);
            return noteRepo.save(note);
        }

        Admin admin = adminRepo.findByEmail(email);
        if (admin != null) {
            note.setAdmin(admin);
            return noteRepo.save(note);
        }

        throw new AccessDeniedException("Not authorized to create a note.");
    }

    @Override
    public MessageResponse UpdateNote(Note note, String jwt) {
        String email = jwtService.extractUserName(jwt);
        Note existing = noteRepo.findById(note.getId())
                .orElseThrow(() -> new RuntimeException("Note not found."));

        if (!isOwner(existing, email)) {
            throw new AccessDeniedException("You are not authorized to update this note.");
        }

        existing.setContent(note.getContent());
        noteRepo.save(existing);
        return new MessageResponse("Note updated successfully.");
    }

    @Override
    public MessageResponse DeleteNote(UUID noteId, String jwt) {
        String email = jwtService.extractUserName(jwt);
        Note note = noteRepo.findById(noteId)
                .orElseThrow(() -> new RuntimeException("Note not found."));

        if (!isOwner(note, email)) {
            throw new AccessDeniedException("You are not authorized to delete this note.");
        }

        noteRepo.delete(note);
        return new MessageResponse("Note deleted successfully.");
    }

    @Override
    public List<Note> getAllNotes(String jwt) {
        String email = jwtService.extractUserName(jwt);

        User user = userRepo.findByEmail(email);
        if (user != null) {
            return noteRepo.findAllByUserId(user.getId());
        }

        Admin admin = adminRepo.findByEmail(email);
        if (admin != null) {
            return noteRepo.findAllByAdminId(admin.getId());
        }

        throw new AccessDeniedException("Not authorized.");
    }

    @Override
    public Note getNoteById(UUID id, String jwt) {
        String email = jwtService.extractUserName(jwt);
        Note note = noteRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Note not found."));

        if (!isOwner(note, email)) {
            throw new AccessDeniedException("You are not authorized to view this note.");
        }

        return note;
    }

    private boolean isOwner(Note note, String email) {
        return (note.getUser() != null && note.getUser().getEmail().equals(email)) ||
                (note.getAdmin() != null && note.getAdmin().getEmail().equals(email));
    }
}
