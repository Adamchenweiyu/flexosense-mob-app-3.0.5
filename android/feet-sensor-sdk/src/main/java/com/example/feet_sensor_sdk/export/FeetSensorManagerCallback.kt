package com.example.feet_sensor_sdk.export

import android.bluetooth.BluetoothDevice
import com.example.feet_sensor_sdk.core.CoreHandlerCallBack
import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.BatteryInfo
import com.example.feet_sensor_sdk.core.model.DeviceInfo
import com.example.feet_sensor_sdk.core.model.ErrorCode
import com.example.feet_sensor_sdk.core.model.ImuData
import com.example.feet_sensor_sdk.core.model.MagneticData
import com.example.feet_sensor_sdk.core.model.PressureData
import com.example.feet_sensor_sdk.core.model.TimeStamp

interface FeetSensorManagerCallback : CoreHandlerCallBack {
    // Connection
    override fun onFoundDevice(device: BluetoothDevice)
    override fun onConnected(handler: DeviceHandler)
    override fun onDisConnected(handler: DeviceHandler)

    // Data response
    override fun onDeviceInfoRsp(deviceInfo: DeviceInfo, handler: DeviceHandler)
    override fun onTimeStampRsp(timeStamp: TimeStamp, handler: DeviceHandler)
    override fun onErrorCodeRsp(errorCode: ErrorCode, handler: DeviceHandler)
    override fun onBatteryInfoRsp(batteryInfo: BatteryInfo, handler: DeviceHandler)

    // Streaming data
    override fun onImuNotified(imuData: ImuData, handler: DeviceHandler)
    override fun onMagNotified(magneticData: MagneticData, handler: DeviceHandler)
    override fun onPressureNotified(pressureData: PressureData, handler: DeviceHandler)
}