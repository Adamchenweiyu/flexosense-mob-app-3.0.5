package com.example.feet_sensor_sdk.core.parser

import com.example.feet_sensor_sdk.core.enum.CommandCode
import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.Header
import com.example.feet_sensor_sdk.core.model.Packet
import com.example.feet_sensor_sdk.util.ByteUtils
import java.util.concurrent.ArrayBlockingQueue
import java.util.concurrent.BlockingQueue


class DataParser(private val handler: DeviceHandler, private val callback: (Packet) -> Unit) :
    Runnable {
    private val buffer: BlockingQueue<ByteArray> = ArrayBlockingQueue(500)

    override fun run() {
        while (!handler.executor.isShutdown &&
            !handler.executor.isTerminated
        ) {
            try {
                val bytesPacket = buffer.take()
                parse(bytesPacket)
            } catch (e: InterruptedException) {
                e.printStackTrace()
            }
        }
    }

    fun push(bytesPacket: ByteArray) {
        buffer.put(bytesPacket)
    }


    private fun parse(bytesPacket: ByteArray) {
        val header = readHeader(bytesPacket)
        if (header.commandCode != null) {
            val data = readData(bytesPacket)
            callback(Packet(header, data))
        }
    }

    /** Packet structure: */
    /** Header [CMD(1 byte) , LEN(1 byte) , MSG_INDEX(2 bytes), DATA(256 bytes)] */

    /** Header is from pos 0 to 4  of packet */
    private fun readHeader(bytesPacket: ByteArray): Header {
        val headerBytes = ByteUtils.subByteStartStopArray(bytesPacket, 0, 4)
        return Header(
            CommandCode.fromValue(headerBytes[0].toInt() and 0xFF),
            headerBytes[1].toInt() and 0xFF,
            (bytesPacket[2].toInt() and 0xFF) or ((bytesPacket[3].toInt() and 0xFF) shl 8),
        )
    }

    /** Data is from pos 4 to length of packet */
    private fun readData(bytesPacket: ByteArray): ByteArray {
        return ByteUtils.subByteStartStopArray(bytesPacket, 4, bytesPacket.size)
    }
}