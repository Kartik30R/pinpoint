package com.nxquar.pinpoint.DTO;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.nxquar.pinpoint.constant.Role;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AuthRequest {

    private String email;
    private String phone;
    private String password;
    private Role role;
    private String jwt;
    private String statusCode;
    private String error;
    private String message;

}
