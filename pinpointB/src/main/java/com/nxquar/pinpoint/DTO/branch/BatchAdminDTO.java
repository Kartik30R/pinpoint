package com.nxquar.pinpoint.DTO.branch;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BatchAdminDTO {
    private UUID id;
    private String name;
}
