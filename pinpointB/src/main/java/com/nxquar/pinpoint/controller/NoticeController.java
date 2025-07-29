package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Notice;
import com.nxquar.pinpoint.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/notices")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    @PostMapping
    public ResponseEntity<Notice> createNotice(@RequestBody Notice notice,
                                               @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(noticeService.CreateNotice(notice, token));
    }

    @PutMapping
    public ResponseEntity<MessageResponse> updateNotice(@RequestBody Notice notice,
                                                        @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(noticeService.updateNotice(notice, token));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<MessageResponse> deleteNotice(@PathVariable UUID id,
                                                        @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(noticeService.deleteNotice(id, token));
    }
    @GetMapping("/{adminId}")
    public ResponseEntity<List<Notice>> getAllNoticeByAdmin(@PathVariable UUID adminId) {
        return ResponseEntity.ok(noticeService.getAllNotice(adminId));
    }
}
