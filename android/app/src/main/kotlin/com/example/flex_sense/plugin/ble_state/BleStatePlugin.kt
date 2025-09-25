package com.example.flex_sense.plugin.ble_state

import android.content.Context
import com.example.feet_sensor_sdk.ble.BleStateController
import com.example.flex_sense.plugin.ChannelNames
import com.example.flex_sense.plugin.ble_state.constant.BleStateEvent
import com.example.flex_sense.plugin.ble_state.constant.BleStateMethod
import com.example.flex_sense.plugin.device_core.event.DeviceCoreEventHandler
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class BleStatePlugin : FlutterPlugin, MethodChannel.MethodCallHandler,
    BleStateController.BluetoothStateListener {

    private lateinit var mContext: Context
    private val eventHandler = DeviceCoreEventHandler()

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        try {
            mContext = binding.applicationContext

            // SET METHOD CHANNEL
            val methodChannel =
                MethodChannel(binding.binaryMessenger, ChannelNames.BLE_STATE_METHOD_CHANNEL)
            methodChannel.setMethodCallHandler(this)

            // SET EVENT CHANNEL
            val eventChannel =
                EventChannel(binding.binaryMessenger, ChannelNames.BLE_STATE_EVENT_CHANNEL)
            eventChannel.setStreamHandler(eventHandler)

            BleStateController.getInstance(mContext).setListener(this)

        } catch (ex: Exception) {
            ex.printStackTrace()
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            BleStateMethod.ENABLE_BLE.value -> enableBle(result)
            BleStateMethod.IS_BLE_ENABLED.value -> isBleEnable(result)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }

    private fun enableBle(result: MethodChannel.Result) {
        BleStateController.getInstance(mContext).enableBtAdapter(mContext)
        result.success(true)
    }

    private fun isBleEnable(result: MethodChannel.Result) {
        result.success(BleStateController.getInstance(mContext).isBluetoothEnabled)
    }

    // Implement BleStateController.BluetoothStateListener
    override fun onBluetoothOn() {
        val map = HashMap<String, Any>()
        map["state"] = "on"
        eventHandler.send(BleStateEvent.BLUETOOTH_STATE.value, map)
    }

    override fun onBluetoothOff() {
        val map = HashMap<String, Any>()
        map["state"] = "off"
        eventHandler.send(BleStateEvent.BLUETOOTH_STATE.value, map)
    }
}