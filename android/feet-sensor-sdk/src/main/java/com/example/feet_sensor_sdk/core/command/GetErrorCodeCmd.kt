package com.example.feet_sensor_sdk.core.command

import com.example.feet_sensor_sdk.core.enum.CommandCode
import com.example.feet_sensor_sdk.core.handler.DeviceHandler


object GetErrorCodeCmd {
    fun send(handler: DeviceHandler) {
        val builder = CommandBuilder.build(CommandCode.ERROR_CODE_GET)
        handler.write(builder)
    }
}