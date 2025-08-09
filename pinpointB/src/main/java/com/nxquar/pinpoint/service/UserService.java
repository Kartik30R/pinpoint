package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.UpdateUserDto;
import com.nxquar.pinpoint.DTO.UserDetailDto;
import com.nxquar.pinpoint.DTO.UserListDto;
import com.nxquar.pinpoint.Model.Users.User;

import java.util.List;
import java.util.UUID;

public interface UserService {
//    public MessageResponse createUser(AuthRequest request);
     public List<UserListDto> getAllUser(UUID id, String jwt);
     public UserDetailDto getUserById(UUID id, String jwt);
     public MessageResponse deleteUser(UUID id,String jwt);
     public MessageResponse UpdateUser(UUID id, String jwt, UpdateUserDto updatedUser);

}
