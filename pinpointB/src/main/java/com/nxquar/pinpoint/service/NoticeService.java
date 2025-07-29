package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Notice;

import java.security.PublicKey;
import java.util.List;
import java.util.UUID;

public interface NoticeService {
   public Notice CreateNotice(Notice notice,String jwt);
   public MessageResponse updateNotice(Notice notice,String jwt);
   public  MessageResponse deleteNotice(UUID id, String jwt);
   public List<Notice> getAllNotice(UUID id);
}
