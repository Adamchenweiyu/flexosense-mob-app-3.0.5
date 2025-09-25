package com.example.feet_sensor_sdk.core.model

data class MagneticData(
    val x: List<Int>,
    val y: List<Int>,
    val z: List<Int>,
    val epochTime: Long,
    val msgIndex: Int
)
