package com.example.feet_sensor_sdk.core.command

import com.example.feet_sensor_sdk.core.enum.CommandCode
import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import java.nio.ByteBuffer
import java.nio.ByteOrder

// TODO: Review / 1000 from flutter site
object SetTimeStampCmd {
    fun send(epochTime: Long, handler: DeviceHandler) {
        val epochTimeBytes = formatEpochTime(epochTime)
        val builder = CommandBuilder.build(CommandCode.PACKET_CMD_TIMESTAMP_SET, epochTimeBytes)

        handler.write(builder)
    }

    /** Data format
     *
     *  uint64_t     epoch_time
     *
     * */

    private fun formatEpochTime(epochTime: Long): ByteArray {
        // The size of the epoch_time in bytes (uint64_t)
        val EPOCH_TIME_SIZE = 8
        val buffer = ByteBuffer.allocate(EPOCH_TIME_SIZE)
        buffer.order(ByteOrder.LITTLE_ENDIAN)
        buffer.putLong(epochTime)
        return buffer.array()
    }
}