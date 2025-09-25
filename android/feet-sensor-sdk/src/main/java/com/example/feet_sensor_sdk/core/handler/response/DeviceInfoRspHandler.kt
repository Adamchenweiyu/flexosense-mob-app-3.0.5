package com.example.feet_sensor_sdk.core.handler.response

import com.example.feet_sensor_sdk.core.handler.DeviceHandler
import com.example.feet_sensor_sdk.core.model.DeviceInfo

/** Data format
 *
 *  char    fw_ver[3]          ([0]: MAJOR; [1]: MINOR; [2]: PATCH; Example: 1.0.1)
 *  char    hw_ver[3]          ([0]: MAJOR; [1]: MINOR; [2]: PATCH; Example: 1.0.1)
 *  char    mac_addr[6]
 *  char    device_name[32]
 *
 * */

object DeviceInfoRspHandler {
    fun handle(data: ByteArray, handler: DeviceHandler) {
        try {
            val fwVerBytes = data.sliceArray(0..2)
            val hwVerBytes = data.sliceArray(3..5)
            val addressBytes = data.sliceArray(6..11)
            val deviceNameBytes = data.sliceArray(12..43)

            val fwVerMajor = fwVerBytes[0].toInt() and 0xFF
            val fwVerMinor = fwVerBytes[1].toInt() and 0xFF
            val fwVerPatch = fwVerBytes[2].toInt() and 0xFF
            val fwVer = "$fwVerMajor.$fwVerMinor.$fwVerPatch"

            val hwVerMajor = hwVerBytes[0].toInt() and 0xFF
            val hwVerMinor = hwVerBytes[1].toInt() and 0xFF
            val hwVerPatch = hwVerBytes[2].toInt() and 0xFF
            val hwVer = "$hwVerMajor.$hwVerMinor.$hwVerPatch"

            val address = addressBytes.joinToString(":") { String.format("%02X", it) }

            val deviceName = deviceNameBytes.takeWhile { it != 0.toByte() }
                .toByteArray()
                .toString(Charsets.UTF_8)

            val deviceInfo = DeviceInfo(
                fwVer,
                hwVer,
                address,
                deviceName,
            )

            handler.callBack.onDeviceInfoRsp(deviceInfo, handler)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}