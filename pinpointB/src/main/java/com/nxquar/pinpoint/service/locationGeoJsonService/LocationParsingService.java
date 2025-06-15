package com.nxquar.pinpoint.service.locationGeoJsonService;

import com.fasterxml.jackson.databind.JsonNode;
import com.nxquar.pinpoint.Model.Building;
import com.nxquar.pinpoint.Model.Floor;
import com.nxquar.pinpoint.Model.Room;
import com.nxquar.pinpoint.Repository.BuildingRepository;
import com.nxquar.pinpoint.Repository.FloorRepository;
import com.nxquar.pinpoint.Repository.RoomRepository;
import org.locationtech.jts.geom.Geometry;
import org.locationtech.jts.geom.GeometryFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.locationtech.jts.geom.*;

@Service
public class    LocationParsingService {

    @Autowired
    private BuildingRepository buildingRepository;

    @Autowired
    private FloorRepository floorRepository;

    @Autowired
    private RoomRepository roomRepository;

    private final GeometryFactory geometryFactory = new GeometryFactory();


    public Building processGeoJsonBuilding(JsonNode geoJson) {
        // Create new building
        Building building = new Building();
        buildingRepository.save(building);

        // Group features by floor
        Map<Integer, List<JsonNode>> featuresByFloor = new HashMap<>();
        JsonNode features = geoJson.get("features");

        for (JsonNode feature : features) {
            int floorLevel = feature.get("properties").get("floor").asInt();

//            if (!featuresByFloor.containsKey(floorLevel)) {
//                featuresByFloor.put(floorLevel, new ArrayList<>());
//            }
//            featuresByFloor.get(floorLevel).add(feature);

            featuresByFloor.computeIfAbsent(floorLevel, k -> new ArrayList<>()).add(feature);
        }

        // Process each floor
        for (Map.Entry<Integer, List<JsonNode>> entry : featuresByFloor.entrySet()) {
            Floor floor = new Floor();
            floor.setLevel(entry.getKey());
            floor.setBuilding(building);
            floorRepository.save(floor);

            // Process rooms on this floor
            for (JsonNode feature : entry.getValue()) {
                Room room = new Room();
                JsonNode properties = feature.get("properties");

                room.setName(properties.get("name").asText());
                room.setType(properties.get("type").asText());
                room.setFloorLevel(properties.get("floor").asInt());
                room.setFloor(floor);

                // Convert GeoJSON geometry to JTS Geometry
                Geometry geometry = parseGeometry(feature.get("geometry"));
                room.setGeometry(geometry);

                roomRepository.save(room);
            }
        }

        return building;
    }

    private Geometry parseGeometry(JsonNode geometryNode) {
        String type = geometryNode.get("type").asText();
        JsonNode coordinatesNode = geometryNode.get("coordinates");

        Geometry geom;
        switch (type) {
            case "Point":
                geom = createPoint(coordinatesNode);
                break;
            case "MultiPoint":
                geom = createMultiPoint(coordinatesNode);
                break;
            case "LineString":
                geom = createLineString(coordinatesNode);
                break;
            case "MultiLineString":
                geom = createMultiLineString(coordinatesNode);
                break;
            case "Polygon":
                geom = createPolygon(coordinatesNode);
                break;
            case "MultiPolygon":
                geom = createMultiPolygon(coordinatesNode);
                break;
            case "GeometryCollection":
                geom = createGeometryCollection(geometryNode);
                break;
            default:
                throw new IllegalArgumentException("Unsupported geometry type: " + type);
        }

        geom.setSRID(4326);  // <---- Set SRID here
        return geom;
    }


    private Point createPoint(JsonNode coordinates) {
        return geometryFactory.createPoint(createCoordinate(coordinates));
    }

    private MultiPoint createMultiPoint(JsonNode coordinates) {
        return geometryFactory.createMultiPoint(createCoordinates(coordinates));
    }

    private LineString createLineString(JsonNode coordinates) {
        return geometryFactory.createLineString(createCoordinates(coordinates));
    }

    private MultiLineString createMultiLineString(JsonNode coordinates) {
        LineString[] lineStrings = new LineString[coordinates.size()];
        for (int i = 0; i < coordinates.size(); i++) {
            lineStrings[i] = createLineString(coordinates.get(i));
        }
        return geometryFactory.createMultiLineString(lineStrings);
    }

    private Polygon createPolygon(JsonNode coordinates) {
        if (coordinates.size() == 0) {
            return geometryFactory.createPolygon();
        }

        LinearRing shell = geometryFactory.createLinearRing(createCoordinates(coordinates.get(0)));
        LinearRing[] holes = new LinearRing[coordinates.size() - 1];

        for (int i = 1; i < coordinates.size(); i++) {
            holes[i - 1] = geometryFactory.createLinearRing(createCoordinates(coordinates.get(i)));
        }

        return geometryFactory.createPolygon(shell, holes);
    }

    private MultiPolygon createMultiPolygon(JsonNode coordinates) {
        Polygon[] polygons = new Polygon[coordinates.size()];
        for (int i = 0; i < coordinates.size(); i++) {
            polygons[i] = createPolygon(coordinates.get(i));
        }
        return geometryFactory.createMultiPolygon(polygons);
    }

    private GeometryCollection createGeometryCollection(JsonNode geometryCollection) {
        JsonNode geometries = geometryCollection.get("geometries");
        Geometry[] geometryArray = new Geometry[geometries.size()];
        for (int i = 0; i < geometries.size(); i++) {
            geometryArray[i] = parseGeometry(geometries.get(i));
        }
        return geometryFactory.createGeometryCollection(geometryArray);
    }

    private Coordinate createCoordinate(JsonNode coordinateNode) {
        return new Coordinate(
                coordinateNode.get(0).asDouble(),
                coordinateNode.get(1).asDouble()
        );
    }

    private Coordinate[] createCoordinates(JsonNode coordinatesArray) {
        Coordinate[] coordinates = new Coordinate[coordinatesArray.size()];
        for (int i = 0; i < coordinatesArray.size(); i++) {
            coordinates[i] = createCoordinate(coordinatesArray.get(i));
        }
        return coordinates;
    }
}