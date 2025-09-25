package com.example.feet_sensor_sdk.core.command

import com.example.feet_sensor_sdk.core.enum.CommandCode
import com.example.feet_sensor_sdk.core.handler.DeviceHandler


object SetStartStopStudyCmd {
    fun send(startStop: Boolean, handler: DeviceHandler) {
        val data = byteArrayOf(if (startStop) 1 else 0)
        val builder = CommandBuilder.build(CommandCode.PACKET_CMD_START_STOP_STUDY, data)
        handler.write(builder)
    }
}