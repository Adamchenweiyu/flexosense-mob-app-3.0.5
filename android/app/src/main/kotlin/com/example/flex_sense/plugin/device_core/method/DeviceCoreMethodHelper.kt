package com.example.flex_sense.plugin.device_core.method

import android.content.Context
import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.export.FeetSensorManager
import com.example.flex_sense.util.SingletonHolder
import io.flutter.plugin.common.MethodChannel


class DeviceCoreMethodHelper private constructor(private val context: Context) {
    companion object : SingletonHolder<DeviceCoreMethodHelper, Context>(::DeviceCoreMethodHelper)

    /** Connection */

    fun isBleEnabled(args: ArrayList<*>?, result: MethodChannel.Result) {
        try {
            val enable = FeetSensorManager.getInstance(context).isBleEnabled()
            result.success(enable)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }


    fun startScan(args: ArrayList<*>?, result: MethodChannel.Result) {
        try {
            FeetSensorManager.getInstance(context).startScan()
            result.success(true)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }

    fun stopScan(args: ArrayList<*>?, result: MethodChannel.Result) {
        try {
            FeetSensorManager.getInstance(context).stopScan()
            result.success(true)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }

    fun connect(args: ArrayList<*>?, result: MethodChannel.Result) {
        try {
            if (args == null) {
                result.success(false)
                return
            }
            val address = args[0] as String
            FeetSensorManager.getInstance(context).connect(address)
            result.success(true)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }

    fun disconnect(args: ArrayList<*>?, result: MethodChannel.Result) {
        try {
            if (args == null) {
                result.success(false)
                return
            }
            val address = args[0] as String
            FeetSensorManager.getInstance(context).disconnect(address)
            result.success(true)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }

//    fun reconnect(args: ArrayList<*>?, result: MethodChannel.Result) {
//        try {
//            if (args == null) {
//                result.success(false)
//                return
//            }
//            val address = args[0] as String
//            FeetSensorManager.getInstance(context).re(address)
//            result.success(true)
//        } catch (e: Exception) {
//            e.printStackTrace()
//            result.success(false)
//        }
//    }

    /** Command */

    fun getDeviceInfo(args: ArrayList<*>?, result: MethodChannel.Result) {
        try {
            if (args == null) {
                result.success(false)
                return
            }

            val address = args[0] as String
            FeetSensorManager.getInstance(context).getDeviceInfo(address)

            result.success(null)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(null)
        }
    }

    fun setStartStopStudy(args: ArrayList<*>?, result: MethodChannel.Result) {
        try {
            if (args == null) {
                result.success(false)
                return
            }

            val address = args[0] as String
            val startStop = args[1] as Boolean
            FeetSensorManager.getInstance(context).setStartStopStudy(address, startStop)

            result.success(true)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }

    fun setTimeStamp(args: ArrayList<*>?, result: MethodChannel.Result) {
        try {
            if (args == null) {
                result.success(false)
                return
            }

            val address = args[0] as String
            val epoch = args[1] as Long
            FeetSensorManager.getInstance(context).setTimeStamp(address, epoch)

            result.success(true)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }

    fun getTimeStamp(args: ArrayList<*>?, result: MethodChannel.Result) {
        try {
            if (args == null) {
                result.success(false)
                return
            }

            val address = args[0] as String
            FeetSensorManager.getInstance(context).getTimeStamp(address)

            result.success(true)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }

    fun getErrorCode(args: ArrayList<*>?, result: MethodChannel.Result) {
        try {
            if (args == null) {
                result.success(false)
                return
            }

            val address = args[0] as String
            FeetSensorManager.getInstance(context).getErrorCode(address)

            result.success(true)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }

    fun getBatteryInfo(args: ArrayList<*>?, result: MethodChannel.Result) {
        try {
            if (args == null) {
                result.success(false)
                return
            }

            val address = args[0] as String
            FeetSensorManager.getInstance(context).getBatteryInfo(address)

            result.success(true)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }


    fun createDeviceMap(handler: DeviceHandler): Map<String, Any> {
        return mapOf(
            /// When turn off Bluetooth, can't use getName() function
            "name" to handler.getDevice().getName(),
            "address" to handler.getDevice().getAddress(),
//            "isCharging" to handler.getDevice().isCharging,
//            "batteryLevel" to handler.getDevice().batteryLevel,
//            "hwVersion" to handler.getDevice().hwVersion,
//            "fwVersion" to handler.getDevice().fwVersion,
//            "model" to handler.getDevice().model,
//            "serialNumber" to handler.getDevice().serialNumber
        )
    }
}