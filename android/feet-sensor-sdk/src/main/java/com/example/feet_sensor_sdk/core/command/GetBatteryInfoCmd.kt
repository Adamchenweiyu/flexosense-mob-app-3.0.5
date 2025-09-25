package com.example.feet_sensor_sdk.core.command

import com.example.feet_sensor_sdk.core.enum.CommandCode
import com.example.feet_sensor_sdk.core.handler.DeviceHandler


object GetBatteryInfoCmd {
    fun send(handler: DeviceHandler) {
        val builder = CommandBuilder.build(CommandCode.BATTERY_INFO_GET)
        handler.write(builder)
    }
}