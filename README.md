# Flex Sense

## Flexo Flutter App

### Overview

Flex Sense is a Flutter application designed for seamless integration with the Feet SDK, enabling BLE communication with Feet Sensor devices. This document provides comprehensive setup instructions for Android development and implementation details for the Feet SDK.

### Useful commands
flutter pub run build_runner build --delete-conflicting-outputs

### Android Setup

#### Gradle Configuration

- Gradle Version: Use Gradle 8.9 (higher versions may work but require testing).

- Update the gradle-wrapper.properties file to:

```
distributionUrl=https\://services.gradle.org/distributions/gradle-8.9-bin.zip
```

#### Java Configuration

- Java Version: Use Java 17 to ensure compatibility with the device_info_plus package.

- Refer to the package requirements: device_info_plus.

### Feet SDK: Android Integration Guide

The Feet SDK provides APIs to enable BLE communication with Feet Sensor devices. Below are the essential components and steps for integration.

#### Core Components

##### FeetSensorManager

This class manages BLE communication with Feet Sensor devices.

##### Key Features

- Singleton instance creation with Android context.

- Essential methods for device management:

  - Scanning for devices

  - Connecting and disconnecting

  - Retrieving device information and battery status

  - Setting and retrieving timestamps

  - Handling error codes

- Interface Definition
```kotlin
/**
 * Interface representing the Feet Sensor Manager.
 * Provides methods to manage Bluetooth Low Energy (BLE) communication with Feet Sensor devices.
 */
interface IFeetSensorManager {

    /**
     * Checks if Bluetooth Low Energy (BLE) is enabled on the device.
     *
     * @return true if BLE is enabled, false otherwise.
     */
    fun isBleEnabled(): Boolean

    /**
     * Starts scanning for available Feet Sensor devices.
     */
    fun startScan()

    /**
     * Stops the ongoing scan for Feet Sensor devices.
     */
    fun stopScan()

    /**
     * Connects to a Feet Sensor device with the specified address.
     *
     * @param address The BLE address of the device to connect to.
     */
    fun connect(address: String)

    /**
     * Disconnects from a connected Feet Sensor device with the specified address.
     *
     * @param address The BLE address of the device to disconnect from.
     */
    fun disconnect(address: String)

    /**
     * Retrieves device information for a connected Feet Sensor device.
     *
     * @param address The BLE address of the device.
     */
    fun getDeviceInfo(address: String)

    /**
     * Sets the timestamp on a connected Feet Sensor device.
     *
     * @param address The BLE address of the device.
     * @param epoch The timestamp in epoch milliseconds to set on the device.
     */
    fun setTimeStamp(address: String, epoch: Long)

    /**
     * Retrieves the timestamp from a connected Feet Sensor device.
     *
     * @param address The BLE address of the device.
     */
    fun getTimeStamp(address: String)

    /**
     * Retrieves the error code from a connected Feet Sensor device.
     *
     * @param address The BLE address of the device.
     */
    fun getErrorCode(address: String)

    /**
     * Retrieves the battery information from a connected Feet Sensor device.
     *
     * @param address The BLE address of the device.
     */
    fun getBatteryInfo(address: String)
}
```

##### FeetSensorManagerCallback

A callback interface to handle events and data from Feet Sensor devices.

Key Features

- Connection events (e.g., device found, connected, disconnected).

- Data response handling (e.g., device info, timestamp, battery info, error codes).

- Streaming data notifications (e.g., IMU, magnetic, and pressure data).

###### Callback Interface Definition

###### Connection Callbacks

```kotlin
/**
 * Interface representing the callback for Feet Sensor Manager.
 * Defines methods to handle connection events, data responses, and streaming data notifications.
 */
interface FeetSensorManagerCallback : CoreHandlerCallBack {

    // Connection Callbacks

    /**
     * Triggered when a Bluetooth device is found during a scan.
     *
     * @param device The found Bluetooth device.
     */
    override fun onFoundDevice(device: BluetoothDevice)

    /**
     * Triggered when a connection is successfully established with a Feet Sensor device.
     *
     * @param handler The handler managing the connected device.
     */
    override fun onConnected(handler: DeviceHandler)

    /**
     * Triggered when the connection to a Feet Sensor device is disconnected.
     *
     * @param handler The handler managing the disconnected device.
     */
    override fun onDisConnected(handler: DeviceHandler)

    // Data Response Callbacks

    /**
     * Triggered when device information is received from a Feet Sensor device.
     *
     * @param deviceInfo The information about the device.
     * @param handler The handler managing the device.
     */
    override fun onDeviceInfoRsp(deviceInfo: DeviceInfo, handler: DeviceHandler)

    /**
     * Triggered when a timestamp response is received from a Feet Sensor device.
     *
     * @param timeStamp The timestamp data from the device.
     * @param handler The handler managing the device.
     */
    override fun onTimeStampRsp(timeStamp: TimeStamp, handler: DeviceHandler)

    /**
     * Triggered when an error code response is received from a Feet Sensor device.
     *
     * @param errorCode The error code data from the device.
     * @param handler The handler managing the device.
     */
    override fun onErrorCodeRsp(errorCode: ErrorCode, handler: DeviceHandler)

    /**
     * Triggered when battery information is received from a Feet Sensor device.
     *
     * @param batteryInfo The battery information from the device.
     * @param handler The handler managing the device.
     */
    override fun onBatteryInfoRsp(batteryInfo: BatteryInfo, handler: DeviceHandler)

    // Streaming Data Callbacks

    /**
     * Triggered when IMU data is notified by a Feet Sensor device.
     *
     * @param imuData The IMU data from the device.
     * @param handler The handler managing the device.
     */
    override fun onImuNotified(imuData: ImuData, handler: DeviceHandler)

    /**
     * Triggered when magnetic data is notified by a Feet Sensor device.
     *
     * @param magneticData The magnetic data from the device.
     * @param handler The handler managing the device.
     */
    override fun onMagNotified(magneticData: MagneticData, handler: DeviceHandler)

    /**
     * Triggered when pressure data is notified by a Feet Sensor device.
     *
     * @param pressureData The pressure data data from the device.
     * @param handler The handler managing the device.
     */
    override fun onPressureNotified(pressureData: PressureData, handler: DeviceHandler)
}
```

Example Implementation

To listen for events, implement the FeetSensorManagerCallback in your class and register it using:

```kotlin
FeetSensorManager.getInstance(context).setListener(yourClass)
```

Sample Code

```kotlin
class DeviceCoreEventPlugin : FlutterPlugin, 
    MethodChannel.MethodCallHandler, FeetSensorManagerCallback {

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val mContext = binding.applicationContext
        val eventChannel = EventChannel(binding.binaryMessenger, "event_channel")
        eventChannel.setStreamHandler(eventHandler)

        // Register listener
        FeetSensorManager.getInstance(mContext).setListener(this)
    }

    override fun onFoundDevice(device: BluetoothDevice) {}
    override fun onConnected(handler: DeviceHandler) {}
}
```

#### SDK Integration

##### Using the .aar Library

To include the Feet SDK, follow these steps:

1. **Add the SDK to Your Project:**

   Place the .aar file in the `libs` directory at the same level as the `src` directory in your Android project.

2. **Update build.gradle:**

```gradle
repositories {
    flatDir {
        dirs 'libs'
    }
}

dependencies {
    implementation(name: 'the-sdk-name', ext: 'aar')
}
```
Replace `the-sdk-name` with the actual name of the `.aar` file.

Note that the 'libs' is the directory storing the sdk, and 'the-sdk-name' is the SDK file name.
The 'libs' is the same level with 'src' directory of the main Android project.


# Build the Android SDK to aar.
cd to /android 

Run this command
```sh

./gradlew :feet-sensor-sdk:assembleRelease

```

After the build completes, the AAR file will be located in the `feet-sensor-sdk/build/outputs/aar/` directory.
Copy the aar file to "libs" and configure like above guide.
