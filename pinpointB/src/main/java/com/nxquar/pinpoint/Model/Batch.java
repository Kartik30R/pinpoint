package com.nxquar.pinpoint.Model;

import com.nxquar.pinpoint.Model.Timetable.Timetable;
import com.nxquar.pinpoint.Model.Users.Admin;
import com.nxquar.pinpoint.Model.Users.Institute;
import com.nxquar.pinpoint.Model.Users.User;
import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Data
public class Batch {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    private String name; // "BTech CSE 2023"
    private String code; // "BTECH-CSE-2023"

    @ManyToOne
    private Institute institute;

    @ManyToMany
    private List<Admin> admins;

    @OneToMany(mappedBy = "batch", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<User> students = new ArrayList<>() ;

    @OneToOne(mappedBy = "batch", cascade = CascadeType.ALL, orphanRemoval = true)
    private Timetable timetable;
}