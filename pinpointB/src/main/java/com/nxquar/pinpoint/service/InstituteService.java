package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.InstituteRequest;
import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Users.Institute;

import java.util.UUID;

public interface InstituteService {
    public Institute getInstituteById(UUID id , String jwt);
    public MessageResponse updateInstitute(InstituteRequest request, String jwt);
    public MessageResponse deleteInstitute(String jwt);

}
