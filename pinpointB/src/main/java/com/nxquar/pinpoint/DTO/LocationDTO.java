package com.nxquar.pinpoint.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocationDTO {

    private UUID userId;
    private double latitude;
    private double longitude;
    private double altitude;
    private String location;
    private Integer floor;
}
