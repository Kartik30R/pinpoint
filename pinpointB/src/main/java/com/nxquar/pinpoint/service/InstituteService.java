package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.InstituteRequest;
import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.branch.InstituteResponse;

import java.util.UUID;

public interface InstituteService {
    InstituteResponse getInstituteById(UUID id, String jwt);
    MessageResponse updateInstitute(InstituteRequest request, String jwt);
    MessageResponse deleteInstitute(String jwt);
}
