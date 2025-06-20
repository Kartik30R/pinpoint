package com.nxquar.pinpoint.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import org.locationtech.jts.geom.Geometry;

import java.util.List;
import java.util.UUID;

@Entity
@Data
public class Floor {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;
    
    private int level;
    
    @ManyToOne
    @JsonIgnore
    private Building building;
    @OneToMany(mappedBy = "floor", cascade = CascadeType.ALL)
    private List<Room> rooms;
}