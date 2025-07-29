package com.nxquar.pinpoint.DTO.branch;

import com.nxquar.pinpoint.Model.Timetable.Timetable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BatchDetailResponse {
    private UUID id;
    private String name;
    private String code;
    private List<BatchUserDTO> students;
    private List<BatchAdminDTO> admins;
    private UUID timetableId;
}
