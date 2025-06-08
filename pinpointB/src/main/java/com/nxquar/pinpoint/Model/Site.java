package com.nxquar.pinpoint.Model;

import com.nxquar.pinpoint.Model.Timetable.Period;
import com.nxquar.pinpoint.Model.Users.Institute;
import jakarta.persistence.*;
import org.locationtech.jts.geom.Polygon;

import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "site")
public class Site {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private UUID id;
    @ManyToOne
    private Institute institute;
    private String name;
    private String type;
    private int floor;
    @OneToMany(mappedBy = "site")
    private List<Period> periods;
    // Store room geometry as a Polygon (could be PostGIS geometry if you're using PostgreSQL with PostGIS)
    @Column(columnDefinition = "geometry(Polygon,4326)")  // You need to ensure PostGIS is set up for spatial data
    private Polygon geometry;
}