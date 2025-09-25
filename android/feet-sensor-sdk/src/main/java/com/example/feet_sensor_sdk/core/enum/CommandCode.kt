package com.example.feet_sensor_sdk.core.enum

import android.util.Log

enum class CommandCode {
    PACKET_CMD_DEVICE_INFO_GET,
    PACKET_CMD_DEVICE_INFO_RSP,
    PACKET_CMD_TIMESTAMP_SET,
    TIMESTAMP_GET,
    TIMESTAMP_RESP,
    ERROR_CODE_GET,
    ERROR_CODE_RESP,
    BATTERY_INFO_GET,
    BATTERY_INFO_RESP,
    IMU_DATA_NOTIFY,
    MAG_DATA_NOTIFY,
    PRESSURE_NOTIFY,
    PACKET_CMD_START_STOP_STUDY;

    fun getValue(): Byte {
        return when (this) {
            PACKET_CMD_DEVICE_INFO_GET -> 3
            PACKET_CMD_DEVICE_INFO_RSP -> 4
            PACKET_CMD_TIMESTAMP_SET -> 5
            TIMESTAMP_GET -> 6
            TIMESTAMP_RESP -> 7
            ERROR_CODE_GET -> 11
            ERROR_CODE_RESP -> 12
            BATTERY_INFO_GET -> 13
            BATTERY_INFO_RESP -> 14
            IMU_DATA_NOTIFY -> 15
            MAG_DATA_NOTIFY -> 16
            PRESSURE_NOTIFY -> 17
            PACKET_CMD_START_STOP_STUDY -> 21
        }
    }

    companion object {
        private val TAG: String = CommandCode::class.java.simpleName

        fun fromValue(value: Int): CommandCode? {
            return when (value) {
                3 -> PACKET_CMD_DEVICE_INFO_GET
                4 -> PACKET_CMD_DEVICE_INFO_RSP
                5 -> PACKET_CMD_TIMESTAMP_SET
                6 -> TIMESTAMP_GET
                7 -> TIMESTAMP_RESP
                11 -> ERROR_CODE_GET
                12 -> ERROR_CODE_RESP
                13 -> BATTERY_INFO_GET
                14 -> BATTERY_INFO_RESP
                15 -> IMU_DATA_NOTIFY
                16 -> MAG_DATA_NOTIFY
                17 -> PRESSURE_NOTIFY
                21 -> PACKET_CMD_START_STOP_STUDY

                else -> {
                    Log.e(TAG, "fromValue: Invalid Request code value: $value")
                    null
                }
            }
        }
    }
}
