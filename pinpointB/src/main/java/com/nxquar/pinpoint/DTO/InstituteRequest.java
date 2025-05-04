package com.nxquar.pinpoint.DTO;

import com.nxquar.pinpoint.Model.Address;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InstituteRequest {
    private String name;
    private String email;
    private String phone;
    private String password;
    private Address address;
}
