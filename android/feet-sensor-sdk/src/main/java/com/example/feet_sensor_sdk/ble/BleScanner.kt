package com.example.feet_sensor_sdk.ble

import android.annotation.SuppressLint
import android.bluetooth.BluetoothDevice
import android.bluetooth.le.BluetoothLeScanner
import android.bluetooth.le.ScanCallback
import android.bluetooth.le.ScanFilter
import android.bluetooth.le.ScanResult
import android.bluetooth.le.ScanSettings
import android.os.ParcelUuid
import android.util.Log

@SuppressLint("MissingPermission")
/**
 * Responsible for scanning device
 */
class BleScanner(
    private val scanner: BluetoothLeScanner,
    private val onDevicesFound: (BluetoothDevice) -> Unit
) {
    companion object {
        val TAG: String = BleScanner::class.java.simpleName
    }

    private val mScanCallback = object : ScanCallback() {
        override fun onScanResult(callBackType: Int, result: ScanResult) {
            super.onScanResult(callBackType, result)
            if (result.device.name == null) return
            onDevicesFound(result.device)
        }

        override fun onScanFailed(errorCode: Int) {
        }

        override fun onBatchScanResults(results: List<ScanResult>) {
        }
    }

    fun startScan() {
        stopScan()

        val settings = ScanSettings.Builder()
            .setScanMode(ScanSettings.SCAN_MODE_LOW_LATENCY)
            .build()

        val serviceUuidFilter = ScanFilter.Builder().setServiceUuid(
            ParcelUuid.fromString(BleConstant.SERVICE_UUID.uppercase())
        ).build()

        val filters: List<ScanFilter> = arrayListOf(serviceUuidFilter)

        Log.d(TAG, "startScan...")
        scanner.startScan(filters, settings, mScanCallback)
    }

    fun stopScan() {
        scanner.stopScan(mScanCallback)
    }
}