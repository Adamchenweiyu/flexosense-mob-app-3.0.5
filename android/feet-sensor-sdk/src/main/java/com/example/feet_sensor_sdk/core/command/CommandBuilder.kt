package com.example.feet_sensor_sdk.core.command

import android.util.Log
import com.example.feet_sensor_sdk.core.enum.CommandCode
import com.example.feet_sensor_sdk.util.toHexString


/** Packet format: Every packet has a header and data part.
 *
 *  Header:
 *  uint8_t     cmd         (Packet command)
 *  uint8_t     len         (Data length)
 *  uint16_t    msg_index   (Message index)
 *
 *  Data:
 *  uint8_t data[256]   (Data (Max size 256 bytes))
 * */

object CommandBuilder {
    fun build(commandCode: CommandCode, data: ByteArray? = null): ByteArray {
        var packet = byteArrayOf()

        /** Build Header */
        packet += commandCode.getValue()    // Add Command code
        packet += 0.toByte()                // Add Data length
        packet += 0.toByte()                // Add Message index
        packet += 0.toByte()                // Add Message index

        /** Build Data */
        if (data != null) {
            packet += data
        }

        Log.d("CommandBuilder", "code: ${commandCode.name}, package: ${packet.toHexString()}")
        return packet
    }
}