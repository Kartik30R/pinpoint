package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.Model.Building;
import com.nxquar.pinpoint.service.locationGeoJsonService.LocationParsingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping("/api/auth/buildings")
public class BuildingController {

    @Autowired
    private LocationParsingService buildingService;

    @PostMapping(
            path = "/upload",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE
    )
    public ResponseEntity<Building> uploadBuildingGeoJson(@RequestParam("file") MultipartFile file) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode geoJson = mapper.readTree(file.getInputStream());
            Building building = buildingService.processGeoJsonBuilding(geoJson);
            return ResponseEntity.ok(building);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }
}