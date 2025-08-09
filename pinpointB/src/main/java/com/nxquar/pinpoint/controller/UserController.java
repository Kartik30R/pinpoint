package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.DTO.UpdateUserDto;
import com.nxquar.pinpoint.DTO.UserDetailDto;
import com.nxquar.pinpoint.DTO.UserListDto;
import com.nxquar.pinpoint.Model.Users.User;
import com.nxquar.pinpoint.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/all/{id}")
    public ResponseEntity<List<UserListDto>> getAllUsers(@PathVariable UUID id,
                                                         @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(userService.getAllUser(id, token));
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserDetailDto> getUserById(@PathVariable UUID id,
                                                     @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(userService.getUserById(id, token));
    }

    @PutMapping("/{id}")
    public ResponseEntity<MessageResponse> updateUser(@PathVariable UUID id,
                                                      @RequestHeader("Authorization") String jwt,
                                                      @RequestBody UpdateUserDto updatedUser) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(userService.UpdateUser(id, token, updatedUser));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<MessageResponse> deleteUser(@PathVariable UUID id,
                                                      @RequestHeader("Authorization") String jwt) {
        String token = jwt.replace("Bearer ", "");
        return ResponseEntity.ok(userService.deleteUser(id, token));
    }
}
