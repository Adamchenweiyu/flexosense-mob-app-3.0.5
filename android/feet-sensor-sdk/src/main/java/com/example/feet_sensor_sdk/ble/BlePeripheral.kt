package com.example.feet_sensor_sdk.ble

import android.annotation.SuppressLint
import android.bluetooth.BluetoothDevice
import android.content.Context
import com.example.feet_sensor_sdk.ble.BleConnection
import com.example.feet_sensor_sdk.ble.BleConnectionCallBack

// TODO: update to real sensor
class BlePeripheral( private  val context: Context, private val device: BluetoothDevice, private val callBack: BleConnectionCallBack) {
    private val connection = BleConnection(context,device, callBack)
    var batteryLevel: Int = 0
    var isCharging: Boolean = false

    var hwVersion: String = ""
    var fwVersion: String = ""
    var model: String = ""
    var serialNumber: String = ""

    fun requestToConnect(autoConnect: Boolean = false) {
        connection.requestToConnect(autoConnect)
    }

    fun reconnect() {
        // reconnect device
        connection.reconnect()
    }

    fun requestToDisconnect() {
        connection.requestToDisconnect()
    }

    fun write(data: ByteArray) {
        connection.write(data)
    }

    fun write(data: String) {
        connection.write(data)
    }

    fun getAddress(): String {
        return device.address
    }

    /**
     * bluetooth off may cause device name is null, cause NullPointerException
     */
    @SuppressLint("MissingPermission")
    fun getName(): String {
        return device.name;
    }
}