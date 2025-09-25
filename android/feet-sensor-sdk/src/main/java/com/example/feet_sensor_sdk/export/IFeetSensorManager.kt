package com.example.feet_sensor_sdk.export

interface IFeetSensorManager {
    fun isBleEnabled(): Boolean

    fun startScan()

    fun stopScan()

    fun connect(address: String)

    fun disconnect(address: String)

    fun getDeviceInfo(address: String)

    fun setStartStopStudy(address: String, startStop: Boolean)

    fun setTimeStamp(address: String, epoch: Long)

    fun getTimeStamp(address: String)

    fun getErrorCode(address: String)

    fun getBatteryInfo(address: String)
}