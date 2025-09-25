package com.example.feet_sensor_sdk.core.handler.response

import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.BatteryInfo
import java.nio.ByteBuffer
import java.nio.ByteOrder

/** Data format
 *
 *  uint8_t     is_charging     (0: Discharging; 1: Charging)
 *  uint8_t     level
 *  float       voltage
 *
 * */

object BatteryInfoRspHandler {
    fun handle(data: ByteArray, handler: DeviceHandler) {
        try {
            val isCharging = data[0].toInt() and 0xFF
            val batteryLevel = data[1].toInt() and 0xFF
            val voltage = ByteBuffer.wrap(data, 2, 4)
                .order(ByteOrder.LITTLE_ENDIAN)
                .float

            val batteryInfo = BatteryInfo(
                isCharging == 1,
                batteryLevel,
                voltage,
            )

            handler.callBack.onBatteryInfoRsp(batteryInfo, handler)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}