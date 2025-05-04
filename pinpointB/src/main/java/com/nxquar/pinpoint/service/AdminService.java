package com.nxquar.pinpoint.service;


import com.nxquar.pinpoint.DTO.AdminRequest;
import com.nxquar.pinpoint.DTO.AuthRequest;
import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Users.Admin;

import java.util.List;
import java.util.UUID;

public interface AdminService {
    MessageResponse createAdmin(AuthRequest request, String jwt);
    Admin getAdminById(UUID adminId, String jwt);
    List<Admin> getAllAdminsByInstitute(UUID instituteId, String jwt);
    MessageResponse updateAdmin(UUID adminId, AdminRequest request, String jwt);
    MessageResponse deleteAdmin(UUID adminId, String jwt);
}
