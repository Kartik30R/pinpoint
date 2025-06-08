package com.nxquar.pinpoint.Model.Timetable;

import jakarta.persistence.*;
import lombok.Data;

import java.time.DayOfWeek;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Data
public class DaySchedule {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;
    
    @Enumerated(EnumType.STRING)
    private DayOfWeek dayOfWeek;
    
    @ManyToOne
    private Timetable timetable;
    
    @OneToMany(mappedBy = "daySchedule", cascade = CascadeType.ALL)
    @OrderBy("periodNumber ASC")
    private List<Period> periods = new ArrayList<>();
}