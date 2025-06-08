package com.nxquar.pinpoint.Model;

import com.nxquar.pinpoint.Model.Users.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocationPoint {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @ManyToOne
    private User user;

    private double latitude;

    private double longitude;

    private double altitude;

    private String location; // Optional name like "Reception", " 101"

    private Integer floor;    // Floor info like "Ground", "1st", "B1"

    private LocalDateTime timestamp;
}
