package com.example.flex_sense.plugin.device_core.enum

/** Make sure the event value matches the DeviceCoreEvent on Flutter side */
enum class DeviceCoreEvent(val value: String) {
    // Connection
    ON_DEVICE_FOUND("onDeviceFound"),
    ON_DEVICE_CONNECTED("onDeviceConnected"),
    ON_DEVICE_DISCONNECTED("onDeviceDisconnected"),

    // Data response
    ON_DEVICE_INFO_RSP("onDeviceInfoRsp"),
    ON_TIME_STAMP_RSP("onTimeStampRsp"),
    ON_ERROR_CODE_RSP("onErrorCodeRsp"),
    ON_BATTERY_INFO_RSP("onBatteryInfoRsp"),

    // Streaming data
    ON_IMU_NOTIFIED("onImuNotified"),
    ON_MAG_NOTIFIED("onMagNotified"),
    ON_PRESSURE_NOTIFIED("onPressureNotified"),
}
