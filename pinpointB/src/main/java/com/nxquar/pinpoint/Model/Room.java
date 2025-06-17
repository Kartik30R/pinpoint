package com.nxquar.pinpoint.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.nxquar.pinpoint.Model.Timetable.Period;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.Type;
import org.hibernate.type.SqlTypes;
import org.locationtech.jts.geom.Geometry;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Data
public class Room {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    private String name;
    private String type;
    private Integer floorLevel;
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @JoinColumn(name = "floor_id")
    private Floor floor;

    @JdbcTypeCode(SqlTypes.GEOMETRY)
    @Column(columnDefinition = "geometry(MultiPolygon,4326)")
    private Geometry geometry;

    @OneToMany(mappedBy = "site")
    @JsonIgnore
    private List<Period> periods = new ArrayList<>();

}