package com.example.flex_sense.plugin.device_core.event

import android.annotation.SuppressLint
import android.bluetooth.BluetoothDevice
import android.content.Context
import android.util.Log
import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.BatteryInfo
import com.example.feet_sensor_sdk.core.model.DeviceInfo
import com.example.feet_sensor_sdk.core.model.ErrorCode
import com.example.feet_sensor_sdk.core.model.ImuData
import com.example.feet_sensor_sdk.core.model.MagneticData
import com.example.feet_sensor_sdk.core.model.PressureData
import com.example.feet_sensor_sdk.core.model.TimeStamp
import com.example.feet_sensor_sdk.export.FeetSensorManager
import com.example.feet_sensor_sdk.export.FeetSensorManagerCallback
import com.example.flex_sense.plugin.ChannelNames
import com.example.flex_sense.plugin.device_core.enum.DeviceCoreEvent
import com.example.flex_sense.plugin.device_core.method.DeviceCoreMethodHelper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class DeviceCoreEventPlugin : FlutterPlugin,
    MethodChannel.MethodCallHandler, FeetSensorManagerCallback {
    companion object {
        val TAG: String = DeviceCoreEventPlugin::class.java.simpleName
    }

    private val eventChannel = ChannelNames.DEVICE_CORE_EVENT_CHANNEL
    private lateinit var mContext: Context
    private val eventHandler = DeviceCoreEventHandler()


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        //NO IMPLEMENTATION
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        try {
            mContext = binding.applicationContext
            val eventChannel = EventChannel(binding.binaryMessenger, eventChannel)
            eventChannel.setStreamHandler(eventHandler)

            FeetSensorManager.getInstance(mContext).setListener(this)
        } catch (ex: Exception) {
            ex.printStackTrace()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        //NO IMPLEMENTATION
    }

    //*************************** DEVICE CALLBACK HANDLER ******************************************

    @SuppressLint("MissingPermission")
    override fun onFoundDevice(device: BluetoothDevice) {
        Log.d(TAG, "onFoundDevice: ${device.name}")

        val map = mapOf(
            "address" to device.address,
            "name" to device.name,
        )

        eventHandler.send(DeviceCoreEventTask(DeviceCoreEvent.ON_DEVICE_FOUND.value, map))
    }

    override fun onConnected(handler: DeviceHandler) {
        val device = DeviceCoreMethodHelper.getInstance(mContext).createDeviceMap(handler)
        eventHandler.send(DeviceCoreEventTask(DeviceCoreEvent.ON_DEVICE_CONNECTED.value, device))
        // Start study automatically when BLE is connected
        val address = handler.getDevice().getAddress()
        FeetSensorManager.getInstance(mContext).setStartStopStudy(address, true)
    }

    override fun onDisConnected(handler: DeviceHandler) {
        val device = DeviceCoreMethodHelper.getInstance(mContext).createDeviceMap(handler)
        eventHandler.send(DeviceCoreEventTask(DeviceCoreEvent.ON_DEVICE_DISCONNECTED.value, device))
    }

    override fun onDeviceInfoRsp(deviceInfo: DeviceInfo, handler: DeviceHandler) {
        val map = mapOf(
            "address" to handler.getDevice().getAddress(),
            "fwVersion" to deviceInfo.fwVersion,
            "hwVersion" to deviceInfo.hwVersion,
            "macAddress" to deviceInfo.macAddress,
            "deviceName" to deviceInfo.deviceName,
        )

        eventHandler.send(DeviceCoreEventTask(DeviceCoreEvent.ON_DEVICE_INFO_RSP.value, map))
    }

    override fun onTimeStampRsp(timeStamp: TimeStamp, handler: DeviceHandler) {
        val map = mapOf(
            "address" to handler.getDevice().getAddress(),
            "epoch" to timeStamp.epoch,
        )

        eventHandler.send(DeviceCoreEventTask(DeviceCoreEvent.ON_TIME_STAMP_RSP.value, map))
    }

    override fun onErrorCodeRsp(errorCode: ErrorCode, handler: DeviceHandler) {
        val map = mapOf(
            "address" to handler.getDevice().getAddress(),
            "imuSensor" to errorCode.imuSensor,
            "magSensor" to errorCode.magSensor,
            "batteryMonitor" to errorCode.batteryMonitor,
            "pressureSensor" to errorCode.pressureSensor,
            "wrongSide" to errorCode.wrongSide,
        )

        eventHandler.send(DeviceCoreEventTask(DeviceCoreEvent.ON_ERROR_CODE_RSP.value, map))
    }

    override fun onBatteryInfoRsp(batteryInfo: BatteryInfo, handler: DeviceHandler) {
        val map = mapOf(
            "address" to handler.getDevice().getAddress(),
            "isCharging" to batteryInfo.isCharging,
            "level" to batteryInfo.level,
            "voltage" to batteryInfo.voltage,
        )

        eventHandler.send(DeviceCoreEventTask(DeviceCoreEvent.ON_BATTERY_INFO_RSP.value, map))
    }

    override fun onImuNotified(imuData: ImuData, handler: DeviceHandler) {
        val map = mapOf(
            "address" to handler.getDevice().getAddress(),
            "accel" to mapOf(
                "x" to imuData.accelData.x,
                "y" to imuData.accelData.y,
                "z" to imuData.accelData.z
            ),
            "gyros" to mapOf(
                "x" to imuData.gyroData.x,
                "y" to imuData.gyroData.y,
                "z" to imuData.gyroData.z
            ),
            "epoch" to imuData.epochTime,
            "msgIndex" to imuData.msgIndex,
        )

        eventHandler.send(DeviceCoreEventTask(DeviceCoreEvent.ON_IMU_NOTIFIED.value, map))
    }

    override fun onMagNotified(magneticData: MagneticData, handler: DeviceHandler) {
        val map = mapOf(
            "address" to handler.getDevice().getAddress(),
            "x" to magneticData.x,
            "y" to magneticData.y,
            "z" to magneticData.z,
            "epoch" to magneticData.epochTime,
            "msgIndex" to magneticData.msgIndex,
        )

        eventHandler.send(DeviceCoreEventTask(DeviceCoreEvent.ON_MAG_NOTIFIED.value, map))
    }

    override fun onPressureNotified(pressureData: PressureData, handler: DeviceHandler) {
        val map = mapOf(
            "address" to handler.getDevice().getAddress(),
            "voltages" to pressureData.voltages,
        )

        eventHandler.send(DeviceCoreEventTask(DeviceCoreEvent.ON_PRESSURE_NOTIFIED.value, map))
    }
}