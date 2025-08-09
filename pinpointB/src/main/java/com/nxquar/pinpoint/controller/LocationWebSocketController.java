package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.DTO.LocationDTO;
import com.nxquar.pinpoint.Model.LocationPoint;
import com.nxquar.pinpoint.Model.Users.User;
import com.nxquar.pinpoint.Repository.UserRepo;
import com.nxquar.pinpoint.service.UserService;
import com.nxquar.pinpoint.service.locationGeoJsonService.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import java.time.LocalDateTime;

@Controller
public class LocationWebSocketController {

    @Autowired
private LocationService locationService;
    @Autowired
private UserRepo userRepo;

    @MessageMapping("/location")
    @SendTo("/topic/location")
    public void receiveLocation(@Payload LocationDTO location){
       User user = userRepo.findById(location.getUserId()).orElseThrow();
        LocationPoint point = new LocationPoint();
        point.setUser(user);
        point.setLatitude(location.getLatitude());
        point.setLongitude(location.getLongitude());
        point.setAltitude(location.getAltitude());
        point.setLocation(location.getLocation());
        point.setFloor(location.getFloor());
        point.setTimestamp(LocalDateTime.now());

        locationService.saveLocation(point);
    }
}
