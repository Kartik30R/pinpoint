package com.nxquar.pinpoint.service.locationGeoJsonService;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.locationtech.jts.geom.*;
import org.locationtech.jts.geom.impl.CoordinateArraySequence;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class GeoJsonManualParser {
    private static final GeometryFactory GEOMETRY_FACTORY = new GeometryFactory();

    public Geometry parseGeoJsonManually(String geoJson) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(geoJson);

        if (!root.has("type")) {
            throw new IllegalArgumentException("Invalid GeoJSON - missing 'type' field");
        }

        String type = root.get("type").asText();
        
        if ("FeatureCollection".equals(type)) {
            return parseFeatureCollection(root);
        } else if ("Feature".equals(type)) {
            return parseFeature(root);
        } else {
            return parseGeometry(root);
        }
    }

    private Geometry parseFeatureCollection(JsonNode featureCollection) {
        List<Geometry> geometries = new ArrayList<>();
        JsonNode features = featureCollection.get("features");
        
        if (features != null && features.isArray()) {
            for (JsonNode feature : features) {
                geometries.add(parseFeature(feature));
            }
        }
        
        return GEOMETRY_FACTORY.createGeometryCollection(geometries.toArray(new Geometry[0]));
    }

    private Geometry parseFeature(JsonNode feature) {
        if (!feature.has("geometry")) {
            return GEOMETRY_FACTORY.createGeometryCollection();
        }
        return parseGeometry(feature.get("geometry"));
    }

    private Geometry parseGeometry(JsonNode geometryNode) {
        String type = geometryNode.get("type").asText();
        JsonNode coordinatesNode = geometryNode.get("coordinates");

        switch (type) {
            case "Point":
                return createPoint(coordinatesNode);
            case "MultiPoint":
                return createMultiPoint(coordinatesNode);
            case "LineString":
                return createLineString(coordinatesNode);
            case "MultiLineString":
                return createMultiLineString(coordinatesNode);
            case "Polygon":
                return createPolygon(coordinatesNode);
            case "MultiPolygon":
                return createMultiPolygon(coordinatesNode);
            case "GeometryCollection":
                return createGeometryCollection(geometryNode);
            default:
                throw new IllegalArgumentException("Unsupported geometry type: " + type);
        }
    }

    private Point createPoint(JsonNode coordinates) {
        return GEOMETRY_FACTORY.createPoint(createCoordinate(coordinates));
    }

    private MultiPoint createMultiPoint(JsonNode coordinates) {
        return GEOMETRY_FACTORY.createMultiPoint(createCoordinates(coordinates));
    }

    private LineString createLineString(JsonNode coordinates) {
        return GEOMETRY_FACTORY.createLineString(createCoordinates(coordinates));
    }

    private MultiLineString createMultiLineString(JsonNode coordinates) {
        LineString[] lineStrings = new LineString[coordinates.size()];
        for (int i = 0; i < coordinates.size(); i++) {
            lineStrings[i] = createLineString(coordinates.get(i));
        }
        return GEOMETRY_FACTORY.createMultiLineString(lineStrings);
    }

    private Polygon createPolygon(JsonNode coordinates) {
        LinearRing shell = null;
        LinearRing[] holes = new LinearRing[coordinates.size() - 1];
        
        for (int i = 0; i < coordinates.size(); i++) {
            Coordinate[] coords = createCoordinates(coordinates.get(i));
            if (i == 0) {
                shell = GEOMETRY_FACTORY.createLinearRing(coords);
            } else {
                holes[i - 1] = GEOMETRY_FACTORY.createLinearRing(coords);
            }
        }
        
        return GEOMETRY_FACTORY.createPolygon(shell, holes);
    }

    private MultiPolygon createMultiPolygon(JsonNode coordinates) {
        Polygon[] polygons = new Polygon[coordinates.size()];
        for (int i = 0; i < coordinates.size(); i++) {
            polygons[i] = createPolygon(coordinates.get(i));
        }
        return GEOMETRY_FACTORY.createMultiPolygon(polygons);
    }

    private GeometryCollection createGeometryCollection(JsonNode geometryCollection) {
        JsonNode geometries = geometryCollection.get("geometries");
        Geometry[] geometryArray = new Geometry[geometries.size()];
        for (int i = 0; i < geometries.size(); i++) {
            geometryArray[i] = parseGeometry(geometries.get(i));
        }
        return GEOMETRY_FACTORY.createGeometryCollection(geometryArray);
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