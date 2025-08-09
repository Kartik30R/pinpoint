package com.nxquar.pinpoint.Model.Users;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.nxquar.pinpoint.Model.*;
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
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "users")
public class User implements  AppUser{
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
    private Role role=Role.USER;
    @OneToOne
    private Address address;

    @ManyToOne
    private Batch batch;

    private boolean checkedIn;

    private LocalDateTime lastCheckIn;

    private LocalDateTime lastCheckOut;

    private String joinCode; // generated during registration

    @ManyToOne
    private Institute institute;

    @ManyToOne
    @JsonIgnoreProperties("users")
    private Admin admin;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL,orphanRemoval = true)
    private List<LocationPoint> locationHistory=new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL,orphanRemoval = true)
    private List<Note> notes=new ArrayList<>();

    @ManyToMany
    @JoinTable(
        name = "user_notices",
        joinColumns = @JoinColumn(name = "user_id"),
        inverseJoinColumns = @JoinColumn(name = "notice_id")
    )
    private List<Notice> notices=new ArrayList<>();

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
