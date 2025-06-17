package com.nxquar.pinpoint.Model.Timetable;

import com.nxquar.pinpoint.Model.Users.Institute;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Data
public class Subject {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;
    
    private String name;
    private String code;
    
    @ManyToOne
    private Institute institute; // Owner
    

}