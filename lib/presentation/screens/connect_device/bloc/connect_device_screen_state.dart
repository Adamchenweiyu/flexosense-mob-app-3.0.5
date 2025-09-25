// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flex_sense/plugin/device_core/models/connected_device.dart';
import 'package:flex_sense/plugin/device_core/models/found_device.dart';

enum ScreenState {
  none,
  checkPermission,
  checkBluetooth,
  checkLocation,
  scanning,
  stopScanning,
  deviceConnecting,
  deviceConnected,
  error,
}

enum DialogState {
  none,
  requireBluetoothPermission,
  requireLocationPermission,
  bluetoothNotAvailable,
  locationNotAvailable,
  pairingDevice,
  pairingFailed,
}

class ConnectDeviceScreenState {
  ScreenState screenState;
  DialogState dialogState;

  List<ConnectedDevice> connectedDevices;
  List<FoundDevice> foundDevices;
  FoundDevice? connectingDevice;

  ConnectDeviceScreenState({
    this.screenState = ScreenState.none,
    this.dialogState = DialogState.none,
    required this.connectedDevices,
    required this.foundDevices,
    this.connectingDevice,
  });

  ConnectDeviceScreenState copyWith({
    ScreenState? screenState,
    DialogState? dialogState,
    List<ConnectedDevice>? connectedDevices,
    List<FoundDevice>? foundDevices,
    FoundDevice? connectingDevice,
  }) {
    return ConnectDeviceScreenState(
      screenState: screenState ?? this.screenState,
      dialogState: dialogState ?? this.dialogState,
      connectedDevices: connectedDevices ?? this.connectedDevices,
      foundDevices: foundDevices ?? this.foundDevices,
      connectingDevice: connectingDevice ?? this.connectingDevice,
    );
  }
}
