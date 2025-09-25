package com.example.feet_sensor_sdk.core

import android.bluetooth.BluetoothDevice
import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.BatteryInfo
import com.example.feet_sensor_sdk.core.model.DeviceInfo
import com.example.feet_sensor_sdk.core.model.ErrorCode
import com.example.feet_sensor_sdk.core.model.ImuData
import com.example.feet_sensor_sdk.core.model.MagneticData
import com.example.feet_sensor_sdk.core.model.PressureData
import com.example.feet_sensor_sdk.core.model.TimeStamp

interface CoreHandlerCallBack {
     // Connection
     fun onFoundDevice(device: BluetoothDevice)
     fun onConnected(handler: DeviceHandler)
     fun onDisConnected(handler: DeviceHandler)

     // Data response
     fun onDeviceInfoRsp(deviceInfo: DeviceInfo, handler: DeviceHandler)
     fun onTimeStampRsp(timeStamp: TimeStamp, handler: DeviceHandler)
     fun onErrorCodeRsp(errorCode: ErrorCode, handler: DeviceHandler)
     fun onBatteryInfoRsp(batteryInfo: BatteryInfo, handler: DeviceHandler)

     // Streaming data
     fun onImuNotified(imuData: ImuData, handler: DeviceHandler)
     fun onMagNotified(magneticData: MagneticData, handler: DeviceHandler)
     fun onPressureNotified(pressureData: PressureData, handler: DeviceHandler)
}