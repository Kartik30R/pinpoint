package com.nxquar.pinpoint.DTO;

import com.nxquar.pinpoint.DTO.branch.BatchListResponse;
import com.nxquar.pinpoint.Model.Address;
import com.nxquar.pinpoint.Model.Users.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDetailDto {
    private UUID id;
    private String name;
    private String email;
    private String phone;
    private String role;
    private boolean isVerified;
    private Address address;
    private BatchListResponse batch;
    private UUID instituteId;
    private UUID adminId;
    private String adminName;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public static UserDetailDto fromEntity(User user) {
        return new UserDetailDto(
                user.getId(),
                user.getName(),
                user.getEmail(),
                user.getPhone(),
                user.getRole().toString(),
                user.isVerified(),
                user.getAddress(),
                user.getBatch() != null
                        ? new BatchListResponse(
                        user.getBatch().getId(),
                        user.getBatch().getName(),
                        user.getBatch().getCode()
                )
                        : null,
                user.getInstitute() != null ? user.getInstitute().getId() : null,
                user.getAdmin() != null ? user.getAdmin().getId() : null,
                user.getAdmin() != null ? user.getAdmin().getName() : null,
                user.getCreatedAt(),
                user.getUpdatedAt()
        );
    }

}
