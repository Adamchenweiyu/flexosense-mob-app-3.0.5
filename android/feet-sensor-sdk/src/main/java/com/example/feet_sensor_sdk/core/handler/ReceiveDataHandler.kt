package com.example.feet_sensor_sdk.core.handler

import android.util.Log
import com.example.feet_sensor_sdk.core.enum.CommandCode
import com.example.feet_sensor_sdk.core.handler.notify.ImuNotifiedHandler
import com.example.feet_sensor_sdk.core.handler.notify.MagNotifiedHandler
import com.example.feet_sensor_sdk.core.handler.notify.PressureNotifiedHandler
import com.example.feet_sensor_sdk.core.handler.response.BatteryInfoRspHandler
import com.example.feet_sensor_sdk.core.handler.response.DeviceInfoRspHandler
import com.example.feet_sensor_sdk.core.handler.response.ErrorCodeRspHandler
import com.example.feet_sensor_sdk.core.handler.response.TimeStampRspHandler
import com.example.feet_sensor_sdk.core.model.Packet

val TAG: String = ReceiveDataHandler::class.java.simpleName

object ReceiveDataHandler {

    fun handle(packet: Packet, handler: DeviceHandler) {
        // Log.d(TAG, "handle: ${packet.header.commandCode}")
        when (packet.header.commandCode) {

            /** Responses */

            CommandCode.PACKET_CMD_DEVICE_INFO_RSP -> {
                DeviceInfoRspHandler.handle(packet.data, handler)
            }

            CommandCode.TIMESTAMP_RESP -> {
                TimeStampRspHandler.handle(packet.data, handler)
            }

            CommandCode.ERROR_CODE_RESP -> {
                ErrorCodeRspHandler.handle(packet.data, handler)
            }

            CommandCode.BATTERY_INFO_RESP -> {
                BatteryInfoRspHandler.handle(packet.data, handler)
            }

            /** Notifications */

            CommandCode.IMU_DATA_NOTIFY -> {
                ImuNotifiedHandler.handle(packet.data, handler, packet.header.msgIndex)
            }

            CommandCode.MAG_DATA_NOTIFY -> {
                MagNotifiedHandler.handle(packet.data, handler, packet.header.msgIndex)
            }

            CommandCode.PRESSURE_NOTIFY -> {
                PressureNotifiedHandler.handle(packet.data, handler)
            }

            else -> {
                Log.e(TAG, "Unknown command code: ${packet.header.commandCode}")
            }
        }
    }
}