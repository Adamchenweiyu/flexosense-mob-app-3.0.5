package com.example.feet_sensor_sdk.core.model

data class BatteryInfo(
    val isCharging: Boolean,
    val level: Int,
    val voltage: Float,
)