package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.LocationPoint;

import java.util.List;
import java.util.UUID;

public interface LocationService {
    public MessageResponse saveLocation(LocationPoint point);
    public List<LocationPoint> getUserLocation(UUID id, String jwt);
}
