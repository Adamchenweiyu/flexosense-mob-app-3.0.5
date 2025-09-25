package com.example.feet_sensor_sdk.core.handler.response

import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.ErrorCode

/** Data format
 *
 *  uint8_t     imu_sensor          (0: Normal; 1: Error)
 *  uint8_t     mag_sensor          (0: Normal; 1: Error)
 *  uint8_t     battery_monitor     (0: Normal; 1: Error)
 *  uint8_t     pressure_sensor     (0: Normal; 1: Error)
 *
 * */

object ErrorCodeRspHandler {
    fun handle(data: ByteArray, handler: DeviceHandler) {
        try {
            val imuSensor = data[0].toInt() and 0xFF
            val magSensor = data[1].toInt() and 0xFF
            val batteryMonitor = data[2].toInt() and 0xFF
            val pressureSensor = data[3].toInt() and 0xFF
            val wrongSide = data[4].toInt() and 0xFF

            val errorCode = ErrorCode(
                imuSensor,
                magSensor,
                batteryMonitor,
                pressureSensor,
                wrongSide,
            )

            handler.callBack.onErrorCodeRsp(errorCode, handler)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}