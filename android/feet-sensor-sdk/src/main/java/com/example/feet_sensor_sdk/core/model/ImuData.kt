package com.example.feet_sensor_sdk.core.model

data class ImuData(
    val accelData: AccelData,
    val gyroData: GyroData,
    val epochTime: Long,
    val msgIndex: Int
)
