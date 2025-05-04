package com.nxquar.pinpoint.DTO;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nxquar.pinpoint.Model.Address;
import com.nxquar.pinpoint.Model.Users.Institute;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AdminRequest {
    private String name;
    private String email;
    private String phone;
    private String password;  // Optional field for updates
    private Address address;
    private UUID instituteId;
}
