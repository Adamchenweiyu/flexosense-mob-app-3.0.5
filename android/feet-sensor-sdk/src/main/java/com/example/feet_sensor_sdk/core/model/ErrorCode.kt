package com.example.feet_sensor_sdk.core.model

data class ErrorCode(
    val imuSensor: Int,
    val magSensor: Int,
    val batteryMonitor: Int,
    val pressureSensor: Int,
    val wrongSide: Int,
)