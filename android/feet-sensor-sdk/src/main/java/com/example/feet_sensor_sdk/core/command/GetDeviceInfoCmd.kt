package com.example.feet_sensor_sdk.core.command

import com.example.feet_sensor_sdk.core.enum.CommandCode
import com.example.feet_sensor_sdk.core.handler.DeviceHandler


object GetDeviceInfoCmd {
    fun send(handler: DeviceHandler) {
        val builder = CommandBuilder.build(CommandCode.PACKET_CMD_DEVICE_INFO_GET)
        handler.write(builder)
    }
}