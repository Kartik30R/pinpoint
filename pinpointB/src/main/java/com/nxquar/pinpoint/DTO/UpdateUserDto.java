package com.nxquar.pinpoint.DTO;

import com.nxquar.pinpoint.Model.Address;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpdateUserDto {
    private String name;
    private String phone;
    private boolean isVerified;
    private Address address;
    private UUID batchId;
    private UUID adminId;
}
