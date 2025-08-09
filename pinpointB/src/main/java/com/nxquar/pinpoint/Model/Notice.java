package com.nxquar.pinpoint.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.nxquar.pinpoint.Model.Users.Admin;
import com.nxquar.pinpoint.Model.Users.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    private String title;

    private String message;

    @ManyToOne
    private Admin sentBy;


    @JsonIgnore
    @ManyToMany(mappedBy = "notices")
    private List<User> sentTo=new ArrayList<>();

    private LocalDateTime validUntil;

    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }
}
