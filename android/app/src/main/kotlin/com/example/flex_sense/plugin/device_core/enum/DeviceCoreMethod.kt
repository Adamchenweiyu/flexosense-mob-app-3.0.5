package com.example.flex_sense.plugin.device_core.enum

/** Make sure the method value matches the DeviceCoreMethod on Flutter side */
enum class DeviceCoreMethod(val value: String) {
    // Permissions
    IS_BLE_ENABLED("isBleEnabled"),

    // Scanning
    START_SCAN("startScan"),
    STOP_SCAN("stopScan"),

    // Connection
    CONNECT("connect"),
    DISCONNECT("disconnect"),
    RECONNECT("reconnect"),
    RECONNECT_DEVICES("reconnectDevices"),

    // Device commands
    GET_DEVICE_INFO("getDeviceInfo"),
    SET_START_STOP_STUDY("setStartStopStudy"),
    SET_TIME_STAMP("setTimeStamp"),
    GET_TIME_STAMP("getTimeStamp"),
    GET_ERROR_CODE("getErrorCode"),
    GET_BATTERY_INFO("getBatteryInfo"),
}
