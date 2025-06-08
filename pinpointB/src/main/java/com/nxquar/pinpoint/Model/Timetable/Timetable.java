package com.nxquar.pinpoint.Model.Timetable;

import com.nxquar.pinpoint.Model.Batch;
import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Data
public class Timetable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    private String name; // "BTech CSE 2023 - Main Timetable"

    @OneToOne
    @JoinColumn(name = "batch_id")
    private Batch batch;

    @OneToMany(mappedBy = "timetable", cascade = CascadeType.ALL)
    private List<DaySchedule> daySchedules = new ArrayList<>();
}