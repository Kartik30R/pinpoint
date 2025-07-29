package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Users.User;

import java.util.List;
import java.util.UUID;

public interface UserService {
//    public MessageResponse createUser(AuthRequest request);
     public List<User> getAllUser(UUID id,String jwt);
     public User getUserById(UUID id, String jwt);
     public MessageResponse deleteUser(UUID id,String jwt);
     public MessageResponse UpdateUser(UUID id, String jwt,User updatedUser);

}
