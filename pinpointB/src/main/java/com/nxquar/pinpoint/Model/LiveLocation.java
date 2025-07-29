package com.nxquar.pinpoint.Model;

import lombok.Data;
import java.util.UUID;

@Data
public class LiveLocation {
    private UUID userId;
    private double latitude;
    private double longitude;
    private double altitude;
    private String location;
    private Integer floor;
}
