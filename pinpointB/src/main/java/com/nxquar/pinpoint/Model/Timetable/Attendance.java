package com.nxquar.pinpoint.Model.Timetable;

import com.nxquar.pinpoint.Model.Users.User;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Data
public class Attendance {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @ManyToOne
    private Period period; // The specific lecture

    @ManyToOne
    private User student;

    @Enumerated(EnumType.STRING)
    private Status status; // PRESENT, ABSENT, LATE etc.

    private LocalDateTime markedAt;
}
