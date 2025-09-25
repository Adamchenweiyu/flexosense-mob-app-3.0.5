package com.example.feet_sensor_sdk.core.handler.notify

import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.PressureData
import java.nio.ByteBuffer
import java.nio.ByteOrder

object PressureNotifiedHandler {
    const val PRESSURE_SENSOR_CHANNEL_MAX = 14

    fun handle(data: ByteArray, handler: DeviceHandler) {
        try {
            val voltageList: MutableList<Float> = mutableListOf()

            val buffer = ByteBuffer.wrap(data)
            buffer.order(ByteOrder.LITTLE_ENDIAN) // Adjust if your data uses big-endian

            // Extract the 14 float voltage values and convert them to Long
            for (i in 0 until PRESSURE_SENSOR_CHANNEL_MAX) {
                val voltage = buffer.float
                voltageList.add(voltage) // Convert float to raw bits and store as Long
            }

            val pressureData = PressureData(voltageList)
            handler.callBack.onPressureNotified(pressureData, handler)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
