package com.nxquar.pinpoint.Model.Timetable;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.nxquar.pinpoint.Model.Batch;
import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Data
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class Timetable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    private String name; // "BTech CSE 2023 - Main Timetable"

    @JsonIgnore
    @OneToOne
    @JoinColumn(name = "batch_id")
    private Batch batch;

    @OneToMany(mappedBy = "timetable", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DaySchedule> daySchedules = new ArrayList<>();
}