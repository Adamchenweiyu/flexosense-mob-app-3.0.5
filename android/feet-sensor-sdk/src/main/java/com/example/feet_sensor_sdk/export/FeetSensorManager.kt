package com.example.feet_sensor_sdk.export

import android.content.Context
import com.example.feet_sensor_sdk.ble.BleStateController
import com.example.feet_sensor_sdk.core.CoreHandler
import com.example.feet_sensor_sdk.core.command.GetBatteryInfoCmd
import com.example.feet_sensor_sdk.core.command.GetDeviceInfoCmd
import com.example.feet_sensor_sdk.core.command.GetErrorCodeCmd
import com.example.feet_sensor_sdk.core.command.GetTimeStampCmd
import com.example.feet_sensor_sdk.core.command.SetTimeStampCmd
import com.example.feet_sensor_sdk.core.command.SetStartStopStudyCmd
import com.example.feet_sensor_sdk.util.SingletonHolder

class FeetSensorManager private constructor(private val context: Context) : IFeetSensorManager {
    companion object : SingletonHolder<FeetSensorManager, Context>(::FeetSensorManager)

    fun setListener(callBack: FeetSensorManagerCallback) {
        CoreHandler.getInstance(context).setListener(callBack)
    }

    override fun isBleEnabled(): Boolean {
        return BleStateController.getInstance(context).isBluetoothEnabled
    }

    override fun startScan() {
        CoreHandler.getInstance(context).startScan()
    }

    override fun stopScan() {
        CoreHandler.getInstance(context).stopScan()
    }

    override fun connect(address: String) {
        CoreHandler.getInstance(context).requestToConnect(address)
    }

    override fun disconnect(address: String) {
        CoreHandler.getInstance(context).requestToDisconnect(address)
    }

    override fun getDeviceInfo(address: String) {
        val handler = CoreHandler.getInstance(context).getDevice(address)

        handler?.let {
            GetDeviceInfoCmd.send(handler)
        }
    }

    override fun setStartStopStudy(address: String, startStop: Boolean) {
        val handler = CoreHandler.getInstance(context).getDevice(address)

        handler?.let {
            SetStartStopStudyCmd.send(startStop, handler)
        }
    }

    override fun setTimeStamp(address: String, epoch: Long) {
        val handler = CoreHandler.getInstance(context).getDevice(address)

        handler?.let {
            SetTimeStampCmd.send(epoch, handler)
        }
    }

    override fun getTimeStamp(address: String) {
        val handler = CoreHandler.getInstance(context).getDevice(address)

        handler?.let {
            GetTimeStampCmd.send(handler)
        }
    }

    override fun getErrorCode(address: String) {
        val handler = CoreHandler.getInstance(context).getDevice(address)

        handler?.let {
            GetErrorCodeCmd.send(handler)
        }
    }

    override fun getBatteryInfo(address: String) {
        val handler = CoreHandler.getInstance(context).getDevice(address)

        handler?.let {
            GetBatteryInfoCmd.send(handler)
        }
    }
}