package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Timetable.Subject;
import com.nxquar.pinpoint.Model.Users.Institute;
import com.nxquar.pinpoint.Repository.AdminRepo;
import com.nxquar.pinpoint.Repository.InstituteRepo;
import com.nxquar.pinpoint.Repository.SubjectRepo;
import com.nxquar.pinpoint.service.InstituteService;
import com.nxquar.pinpoint.service.SubjectService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;


@Service

public class SubjectServiceImpl implements SubjectService {
    @Autowired
    private SubjectRepo subjectRepo;

    @Autowired
    private InstituteRepo instituteRepo;


    @Autowired
    private  AdminRepo adminRepo;

    @Autowired
    JwtService jwtService;

    @Override
    public Subject getSubjectById(UUID id, String jwt) {
        return subjectRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Subject not found with ID: " + id));
    }

    @Override
    public List<Subject> getAllSubjectsByInstitute(UUID instituteId, String jwt) {
        List<Subject> subjects=subjectRepo.findByInstituteId(instituteId);
        return subjects;
    }

    @Override
    public Subject createSubject(Subject subject, String jwt) {
        String email = jwtService.extractUserName(jwt);
        String role = jwtService.extractRole(jwt);

        boolean isInstitute =  role.equals("INSTITUTE");
        boolean isAdmin =  role.equals("ADMIN");
        Institute institute;
        institute = instituteRepo.findByEmail(email);
       if(institute==null){
           institute= adminRepo.findByEmail(email).getInstitute();
       }
        if (!(isInstitute || isAdmin)) {
            throw new AccessDeniedException("You are not authorized to update this subject");
        }

        subject.setInstitute(institute);
        return subjectRepo.save(subject);
    }

    @Override
    public Subject updateSubject(Subject updatedSubject, String jwt) {
        Subject existingSubject = subjectRepo.findById(updatedSubject.getId())
                .orElseThrow(() -> new EntityNotFoundException("Subject not found"));

        String email = jwtService.extractUserName(jwt);
        String role = jwtService.extractRole(jwt);

        boolean isInstitute = existingSubject.getInstitute().getEmail().equals(email) && role.equals("INSTITUTE");
        boolean isAdmin =  role.equals("ADMIN");

        if (!(isInstitute || isAdmin)) {
            throw new AccessDeniedException("You are not authorized to update this subject");
        }


        if (updatedSubject.getName() != null) {
            existingSubject.setName(updatedSubject.getName());
        }

        if (updatedSubject.getCode() != null) {
            existingSubject.setCode(updatedSubject.getCode());
        }

        return subjectRepo.save(existingSubject);
    }
    @Override
    public MessageResponse deleteSubject(UUID id, String jwt) {
        Subject subject = subjectRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Subject not found"));

        String email = jwtService.extractUserName(jwt);
        if (!subject.getInstitute().getEmail().equals(email)) {
            throw new AccessDeniedException("Unauthorized to delete this subject");
        }

        subjectRepo.delete(subject);
        return new MessageResponse("Subject deleted successfully");
    }

}
