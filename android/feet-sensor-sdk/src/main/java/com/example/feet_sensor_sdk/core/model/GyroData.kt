package com.example.feet_sensor_sdk.core.model

data class GyroData(
    val x: List<Short>,
    val y: List<Short>,
    val z: List<Short>,
)