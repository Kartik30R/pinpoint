package com.nxquar.pinpoint.utils;

import java.util.Random;

public class OTPUtil {
    public static String generateOTP() {
        return String.format("%06d", new Random().nextInt(999999));
    }
}