package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Users.User;
import com.nxquar.pinpoint.service.UserService;

import java.util.List;
import java.util.UUID;

public class UserServiceImpl implements UserService {
    @Override
    public List<User> getAllUser(String jwt) {
        return List.of();
    }

    @Override
    public User getUserById(UUID id, String jwt) {
        return null;
    }

    @Override
    public MessageResponse deleteUser(UUID id, String jwt) {
        return null;
    }

    @Override
    public MessageResponse UpdateUser(UUID id, String jwt) {
        return null;
    }
}
