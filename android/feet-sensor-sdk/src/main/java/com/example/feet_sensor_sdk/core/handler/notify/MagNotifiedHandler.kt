package com.example.feet_sensor_sdk.core.handler.notify

import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.MagneticData
import java.nio.ByteBuffer
import java.nio.ByteOrder

object MagNotifiedHandler {
    private val lastMsgIndexMap: MutableMap<String, Int> = mutableMapOf()
    
    fun handle(data: ByteArray, handler: DeviceHandler, msgIndex: Int) {
        try {
            val deviceAddress = handler.getDevice().getAddress()
            val deviceName = handler.getDevice().getName()
            
            val magneticXs : MutableList<Int> = mutableListOf()
            val magneticYs : MutableList<Int> = mutableListOf()
            val magnetics : MutableList<Int> = mutableListOf()

            val EXPECTED_SIZE = 236
            if (data.size != EXPECTED_SIZE) {
                println("Invalid data size: expected $EXPECTED_SIZE bytes, but got ${data.size} bytes.")
            }

            // Check if msgIndex is increasing in series for this specific device
            val lastMsgIndex = lastMsgIndexMap[deviceAddress]
            if (lastMsgIndex != null && msgIndex != lastMsgIndex + 1) {
                println("ERROR MAG: Message index not in series! Device: $deviceName ($deviceAddress) - Expected: ${lastMsgIndex + 1}, Received: $msgIndex")
            }
            lastMsgIndexMap[deviceAddress] = msgIndex

            val buffer = ByteBuffer.wrap(data)
            buffer.order(ByteOrder.LITTLE_ENDIAN) // Adjust if your data uses big-endian

            // Parse epoch_time (8 bytes)
            val epochTime = buffer.long

            // Constants
            val NUM_SAMPLES_MAG = 57   // Total number of int32_t values
            val NUM_MAG_COMPONENTS = 3 // Mag X, Mag Y, Mag Z
            val NUM_SAMPLES = NUM_SAMPLES_MAG / NUM_MAG_COMPONENTS  // Number of samples

            // Parse magnetic data (57 int32_t values = 228 bytes)
            val magData = IntArray(NUM_SAMPLES_MAG)
            for (i in 0 until NUM_SAMPLES_MAG) {
                if (buffer.remaining() < 4) {
                    println("⚠️ MAGNETIC BUFFER WARNING - Not enough data for sample $i, remaining: ${buffer.remaining()} bytes")
                    break
                }
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

            val magneticData = MagneticData(magneticXs, magneticYs, magnetics, epochTime, msgIndex)

            handler.callBack.onMagNotified(magneticData, handler)
        }catch (e: Exception) {
            e.printStackTrace()
        }
    }
}