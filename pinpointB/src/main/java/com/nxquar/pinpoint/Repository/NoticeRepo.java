package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Notice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface NoticeRepo extends JpaRepository<Notice, UUID> {
    List<Notice> findBySentTo_Id(UUID userId);
}
