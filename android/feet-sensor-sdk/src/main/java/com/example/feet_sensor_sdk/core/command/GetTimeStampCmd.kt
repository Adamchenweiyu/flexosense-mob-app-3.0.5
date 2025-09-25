package com.example.feet_sensor_sdk.core.command

import com.example.feet_sensor_sdk.core.enum.CommandCode
import com.example.feet_sensor_sdk.core.handler.DeviceHandler


object GetTimeStampCmd {
    fun send(handler: DeviceHandler) {
        val builder = CommandBuilder.build(CommandCode.TIMESTAMP_GET)
        handler.write(builder)
    }
}