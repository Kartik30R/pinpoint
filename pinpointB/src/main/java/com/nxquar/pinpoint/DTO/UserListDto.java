package com.nxquar.pinpoint.DTO;

import com.nxquar.pinpoint.Model.Users.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserListDto {
    private UUID id;
    private String name;
    private String email;
    private String phone;

    public static UserListDto fromEntity(User user) {
        return new UserListDto(
                user.getId(),
                user.getName(),
                user.getEmail(),
                user.getPhone()
        );
    }

}
