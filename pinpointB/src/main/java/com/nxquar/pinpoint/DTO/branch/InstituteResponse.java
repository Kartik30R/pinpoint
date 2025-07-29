package com.nxquar.pinpoint.DTO.branch;


import com.nxquar.pinpoint.Model.Address;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InstituteResponse {
    private String id;
    private String email;
    private String phone;
    private String name;
    private String geoJsonUrl;
    private Address address;
    private String createdAt;
    private String updatedAt;
    private boolean isVerified;
    private String baseAltitude;

}
