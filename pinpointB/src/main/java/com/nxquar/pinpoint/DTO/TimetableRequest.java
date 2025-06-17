package com.nxquar.pinpoint.DTO;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

import java.util.UUID;

@Data
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class TimetableRequest {
    private UUID id;
    private String name;
    private UUID batchId;
}
