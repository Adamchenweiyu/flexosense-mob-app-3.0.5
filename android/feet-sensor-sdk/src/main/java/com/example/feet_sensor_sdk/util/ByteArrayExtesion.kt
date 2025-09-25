package com.example.feet_sensor_sdk.util

fun ByteArray.toHexString(): String {
    return joinToString(prefix = "[", postfix = "]") {
        String.format("%02X", it)
    }
}