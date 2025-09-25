package com.example.feet_sensor_sdk.core.model

data class DeviceInfo(
    val fwVersion: String,
    val hwVersion: String,
    val macAddress: String,
    val deviceName: String,
)