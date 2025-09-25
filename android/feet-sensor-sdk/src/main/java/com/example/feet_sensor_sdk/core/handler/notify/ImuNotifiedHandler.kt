package com.example.feet_sensor_sdk.core.handler.notify

import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.AccelData
import com.example.feet_sensor_sdk.core.model.GyroData
import com.example.feet_sensor_sdk.core.model.ImuData
import com.example.feet_sensor_sdk.core.model.RollPitchYaw
import java.nio.ByteBuffer
import java.nio.ByteOrder

const val NUM_IMU_VALUES = 60   // Total number of int16_t values
const val NUM_ROLL_PITCH_YAW_VALUES = 30  // Total number of float values
const val NUM_SAMPLES = 10

object ImuNotifiedHandler {
    fun handle(data: ByteArray, handler: DeviceHandler) {
        try {
            val accelXs : MutableList<Short> = mutableListOf()
            val accelYs : MutableList<Short> = mutableListOf()
            val accelZs : MutableList<Short> = mutableListOf()

            val gyroXs : MutableList<Short> = mutableListOf()
            val gyroYs : MutableList<Short> = mutableListOf()
            val gyroZs : MutableList<Short> = mutableListOf()

            val rolls : MutableList<Float> = mutableListOf()
            val pitches : MutableList<Float> = mutableListOf()
            val yaws : MutableList<Float> = mutableListOf()

            val buffer = ByteBuffer.wrap(data)
            buffer.order(ByteOrder.LITTLE_ENDIAN)

            // Parse IMU data (60 int16_t values)
            val rawImuData = ShortArray(NUM_IMU_VALUES)
            for (i in 0 until NUM_IMU_VALUES) {
                rawImuData[i] = buffer.short
            }

            // Parse quaternion data (30 float values)
            val rollPitchYawData = FloatArray(NUM_ROLL_PITCH_YAW_VALUES)
            for (i in 0 until NUM_ROLL_PITCH_YAW_VALUES) {
                rollPitchYawData[i] = buffer.float
            }

            // Iterate over the samples
            for (i in 0 until NUM_SAMPLES) {
                val imuIdx = i * 6
                val quatIdx = i * 3

                // Extract accelerometer and gyroscope data
                val accelX = rawImuData[imuIdx]
                val accelY = rawImuData[imuIdx + 1]
                val accelZ = rawImuData[imuIdx + 2]
                val gyroX = rawImuData[imuIdx + 3]
                val gyroY = rawImuData[imuIdx + 4]
                val gyroZ = rawImuData[imuIdx + 5]

                // Extract roll, pitch, yaw data
                val roll = rollPitchYawData[quatIdx]
                val pitch = rollPitchYawData[quatIdx + 1]
                val yaw = rollPitchYawData[quatIdx + 2]

                // Create an IMUSample instance
                accelXs.add(accelX)
                accelYs.add(accelY)
                accelZs.add(accelZ)
                gyroXs.add(gyroX)
                gyroYs.add(gyroY)
                gyroZs.add(gyroZ)
                rolls.add(roll)
                pitches.add(pitch)
                yaws.add(yaw)

            }

            val accelData = AccelData(accelXs, accelYs, accelZs)
            val gyroData = GyroData(gyroXs, gyroYs, gyroZs)
            val rollPitchYaw = RollPitchYaw(rolls, pitches, yaws)
            val imuData = ImuData(accelData, gyroData, rollPitchYaw)

            handler.callBack.onImuNotified(imuData, handler)

        } catch (e: Exception) {
            println(e)
            e.printStackTrace()
        }
    }
}