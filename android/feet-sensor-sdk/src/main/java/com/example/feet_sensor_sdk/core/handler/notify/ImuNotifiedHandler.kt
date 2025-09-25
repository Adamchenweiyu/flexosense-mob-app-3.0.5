package com.example.feet_sensor_sdk.core.handler.notify

import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.AccelData
import com.example.feet_sensor_sdk.core.model.GyroData
import com.example.feet_sensor_sdk.core.model.ImuData
import java.nio.ByteBuffer
import java.nio.ByteOrder

const val NUM_IMU_VALUES = 108   // Total number of int16_t values
const val NUM_SAMPLES = 18

object ImuNotifiedHandler {
    private val lastMsgIndexMap: MutableMap<String, Int> = mutableMapOf()
    
    fun handle(data: ByteArray, handler: DeviceHandler, msgIndex: Int) {
        try {
            val deviceAddress = handler.getDevice().getAddress()
            val deviceName = handler.getDevice().getName()
            
            // Validate data size
            val EXPECTED_SIZE = 224 // 8 (epoch) + 108*2 (imu data) = 224 bytes
            if (data.size != EXPECTED_SIZE) {
                println("Invalid IMU data size: expected $EXPECTED_SIZE bytes, but got ${data.size} bytes")
            }
            
            // Check if msgIndex is increasing in series for this specific device
            val lastMsgIndex = lastMsgIndexMap[deviceAddress]
            if (lastMsgIndex != null && msgIndex != lastMsgIndex + 1) {
                println("ERROR IMU: Message index not in series! Device: $deviceName ($deviceAddress) - Expected: ${lastMsgIndex + 1}, Received: $msgIndex")
            }
            lastMsgIndexMap[deviceAddress] = msgIndex
            
            val accelXs : MutableList<Short> = mutableListOf()
            val accelYs : MutableList<Short> = mutableListOf()
            val accelZs : MutableList<Short> = mutableListOf()

            val gyroXs : MutableList<Short> = mutableListOf()
            val gyroYs : MutableList<Short> = mutableListOf()
            val gyroZs : MutableList<Short> = mutableListOf()

            val buffer = ByteBuffer.wrap(data)
            buffer.order(ByteOrder.LITTLE_ENDIAN)

            // Skip header (if any), then parse epoch_time (8 bytes)
            // Assuming header is already handled or not present in this buffer
            val epochTime = buffer.long

            // Parse IMU data (108 int16_t values = 216 bytes)
            val rawImuData = ShortArray(NUM_IMU_VALUES)
            for (i in 0 until NUM_IMU_VALUES) {
                if (buffer.remaining() < 2) {
                    println("⚠️ IMU BUFFER WARNING - Not enough data for sample $i, remaining: ${buffer.remaining()} bytes")
                    break
                }
                rawImuData[i] = buffer.short
            }

            // Iterate over the samples
            for (i in 0 until NUM_SAMPLES) {
                val imuIdx = i * 6

                // Extract accelerometer and gyroscope data
                val accelX = rawImuData[imuIdx]
                val accelY = rawImuData[imuIdx + 1]
                val accelZ = rawImuData[imuIdx + 2]
                val gyroX = rawImuData[imuIdx + 3]
                val gyroY = rawImuData[imuIdx + 4]
                val gyroZ = rawImuData[imuIdx + 5]

                // Create an IMUSample instance
                accelXs.add(accelX)
                accelYs.add(accelY)
                accelZs.add(accelZ)
                gyroXs.add(gyroX)
                gyroYs.add(gyroY)
                gyroZs.add(gyroZ)
            }

            val accelData = AccelData(accelXs, accelYs, accelZs)
            val gyroData = GyroData(gyroXs, gyroYs, gyroZs)
            val imuData = ImuData(accelData, gyroData, epochTime, msgIndex)

            handler.callBack.onImuNotified(imuData, handler)

        } catch (e: Exception) {
            println(e)
            e.printStackTrace()
        }
    }
}