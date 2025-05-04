package com.nxquar.pinpoint.Model.Users;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.nxquar.pinpoint.Model.Address;
import com.nxquar.pinpoint.Model.Note;
import com.nxquar.pinpoint.Model.Notice;
import com.nxquar.pinpoint.constant.Role;
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
@AllArgsConstructor
@NoArgsConstructor
public class Admin implements  AppUser{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @Column(unique = true)
    private String email;

    private String phone;
    private String name;
    @JsonIgnore
    private String password;

    @Enumerated(EnumType.STRING)
    private Role role=Role.ADMIN;

@OneToOne
    private Address address;

    @ManyToOne
    private Institute institute;

    @JsonIgnore
    @OneToMany(mappedBy = "admin")
    private List<User> userList=new ArrayList<>();
@JsonIgnore
    @OneToMany(mappedBy = "sentBy")
    private List<Notice> notices=new ArrayList<>();
    @OneToMany(mappedBy = "admin", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Note> notes = new ArrayList<>();

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
    private String otp;
    private LocalDateTime otpExpiry;
    private boolean isVerified;


    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = createdAt;
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }


}
