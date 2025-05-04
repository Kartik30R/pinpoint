package com.nxquar.pinpoint.exception;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class ErrorInfo {
    private String message;
    private String Code;
    private LocalDateTime time;
}
