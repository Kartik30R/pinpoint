package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Notice;
import com.nxquar.pinpoint.Model.Users.Admin;
import com.nxquar.pinpoint.Model.Users.Institute;
import com.nxquar.pinpoint.Repository.AdminRepo;
import com.nxquar.pinpoint.Repository.InstituteRepo;
import com.nxquar.pinpoint.Repository.NoticeRepo;
import com.nxquar.pinpoint.Repository.UserRepo;
import com.nxquar.pinpoint.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;

import java.util.UUID;

public class NoticeServiceImpl implements NoticeService {
@Autowired
JwtService jwtService;
    @Autowired
    UserRepo userRepo;

    @Autowired
    AdminRepo adminRepo;

    @Autowired
    InstituteRepo instituteRepo;

    @Autowired
    NoticeRepo noticeRepo;

    @Override
    public Notice CreateNotice(Notice notice, String jwt) {
        String jwtEmail = jwtService.extractUserName(jwt);
        Admin admin = adminRepo.findByEmail(jwtEmail);

        if (admin == null) {
            throw new AccessDeniedException("Only an admin can create notices.");
        }

        notice.setSentBy(admin);
        return noticeRepo.save(notice);
    }

    @Override
    public MessageResponse updateNotice(Notice notice, String jwt) {
        String jwtEmail = jwtService.extractUserName(jwt);
        Admin admin = adminRepo.findByEmail(jwtEmail);

        if (admin == null) {
            throw new AccessDeniedException("Only an admin can update notices.");
        }

        Notice existing = noticeRepo.findById(notice.getId())
                .orElseThrow(() -> new RuntimeException("Notice not found."));

        if (!existing.getSentBy().getId().equals(admin.getId())) {
            throw new AccessDeniedException("You are not authorized to update this notice.");
        }

        existing.setTitle(notice.getTitle());
        existing.setMessage(notice.getMessage());
        existing.setValidUntil(notice.getValidUntil());

        noticeRepo.save(existing);

        return new MessageResponse("Notice updated successfully.");
    }


    @Override
    public MessageResponse deleteNotice(UUID id, String jwt) {
        String jwtEmail = jwtService.extractUserName(jwt);
        Admin admin = adminRepo.findByEmail(jwtEmail);

        if (admin == null) {
            throw new AccessDeniedException("Only an admin can delete notices.");
        }

        Notice notice = noticeRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Notice not found."));

        if (!notice.getSentBy().getId().equals(admin.getId())) {
            throw new AccessDeniedException("You are not authorized to delete this notice.");
        }

        noticeRepo.delete(notice);
        return new MessageResponse("Notice deleted successfully.");
    }

}
