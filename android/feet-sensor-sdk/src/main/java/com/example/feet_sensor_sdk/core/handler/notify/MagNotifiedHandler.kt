package com.example.feet_sensor_sdk.core.handler.notify

import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.MagneticData
import java.nio.ByteBuffer
import java.nio.ByteOrder

object MagNotifiedHandler {
    fun handle(data: ByteArray, handler: DeviceHandler) {
        try {
            val magneticXs : MutableList<Int> = mutableListOf()
            val magneticYs : MutableList<Int> = mutableListOf()
            val magnetics : MutableList<Int> = mutableListOf()

            val EXPECTED_SIZE = 240
            if (data.size != EXPECTED_SIZE) {
                println("Invalid data size: expected $EXPECTED_SIZE bytes, but got ${data.size} bytes.")

            }

            val buffer = ByteBuffer.wrap(data)
            buffer.order(ByteOrder.LITTLE_ENDIAN) // Adjust if your data uses big-endian

            // Constants
            val NUM_SAMPLES_MAG = 60   // Total number of int32_t values
            val NUM_MAG_COMPONENTS = 3 // Mag X, Mag Y, Mag Z
            val NUM_SAMPLES = NUM_SAMPLES_MAG / NUM_MAG_COMPONENTS  // Number of samples

            // Parse magnetic data (60 int32_t values)
            val magData = IntArray(NUM_SAMPLES_MAG)
            for (i in 0 until NUM_SAMPLES_MAG) {
                magData[i] = buffer.int
            }


            // Iterate over the samples
            for (i in 0 until NUM_SAMPLES_MAG step NUM_MAG_COMPONENTS) {
                val rawMagX = magData[i]
                val rawMagY = magData[i + 1]
                val rawMagZ = magData[i + 2]

                magneticXs.add(rawMagX)
                magneticYs.add(rawMagY)
                magnetics.add(rawMagZ)
            }

            val magneticData = MagneticData(magneticXs, magneticYs, magnetics)

            handler.callBack.onMagNotified(magneticData, handler)
        }catch (e: Exception) {
            e.printStackTrace()
        }
    }
}