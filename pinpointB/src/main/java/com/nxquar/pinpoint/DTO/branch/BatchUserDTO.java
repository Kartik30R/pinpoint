package com.nxquar.pinpoint.DTO.branch;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BatchUserDTO {
    private UUID id;
    private String name;
    private String phone;
}
