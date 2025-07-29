package com.nxquar.pinpoint.mapper;

import com.nxquar.pinpoint.DTO.AdminResponse;
import com.nxquar.pinpoint.Model.Users.Admin;
import com.nxquar.pinpoint.Model.Notice;
import java.util.UUID;
import java.util.stream.Collectors;

public class AdminMapper {

    public static AdminResponse toResponse(Admin admin) {
        return new AdminResponse(
                admin.getId(),
                admin.getEmail(),
                admin.getPhone(),
                admin.getName(),
                admin.getRole().toString(),
                admin.getAddress(),
                admin.getInstitute() != null ? admin.getInstitute().getId() : null,
                admin.getBatch() != null
                        ? admin.getBatch().stream().map(b -> b.getId()).collect(Collectors.toList())
                        : null,
                admin.getNotices(),
                admin.getCreatedAt(),
                admin.getUpdatedAt(),
                admin.isVerified()
        );

    }
}
