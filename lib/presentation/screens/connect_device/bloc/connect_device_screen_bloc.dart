import 'dart:async';
import 'dart:io';

import 'package:flex_sense/presentation/base_bloc/base_cubit.dart';
import 'package:flex_sense/application/enum/scan_state_enum.dart';
import 'package:flex_sense/application/enum/timeout_enum.dart';
import 'package:flex_sense/application/util/logger.dart';
import 'package:flex_sense/application/util/permission_utils.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/data/service/location_service.dart';
import 'package:flex_sense/plugin/ble_state/ble_state_plugin.dart';
import 'package:flex_sense/plugin/device_core/device_core_plugin.dart';
import 'package:flex_sense/plugin/device_core/device_event_task.dart';
import 'package:flex_sense/plugin/device_core/enum/event_enum.dart';
import 'package:flex_sense/plugin/device_core/models/found_device.dart';
import 'package:flex_sense/presentation/globals/global_states/global/global_bloc.dart';
import 'package:flex_sense/presentation/globals/global_states/global/global_state.dart';
import 'package:flex_sense/presentation/globals/global_states/global/reload_param.dart';
import 'package:flex_sense/presentation/screens/connect_device/bloc/connect_device_screen_state.dart';

class ConnectDeviceScreenBloc extends BaseCubit<ConnectDeviceScreenState> {
  ConnectDeviceScreenBloc()
      : super(ConnectDeviceScreenState(
          foundDevices: [],
          connectedDevices: [],
        ));

  StreamSubscription<BluetoothState?>? _bluetoothStateListener;
  Timer? _timeout;

  StreamSubscription<DeviceEventTask?>? _deviceEventListener;

  bool isBluetoothPermissionChecked = false;
  bool isLocationPermissionChecked = false;

  void initState() {
    _setupDeviceEventListener();
    _setupBluetoothListener();
    handleScreenState(ScreenState.checkPermission);
  }

  @override
  Future<void> close() {
    DeviceCorePlugin.stopScan();
    _timeout?.cancel();
    _bluetoothStateListener?.cancel();
    _deviceEventListener?.cancel();
    return super.close();
  }

  void _startTimer(int timeInSecond, Function() callback) {
    _timeout?.cancel();
    _timeout = Timer(Duration(seconds: timeInSecond), callback);
  }

  void handleScreenState(ScreenState screenState) {
    switch (screenState) {
      case ScreenState.checkPermission:
        _handlePermission();
        break;
      case ScreenState.checkBluetooth:
        _checkBluetoothState();
        break;
      case ScreenState.checkLocation:
        _checkLocationState();
        break;
      case ScreenState.scanning:
        _startScanningDevice();
        break;
      case ScreenState.stopScanning:
        _stopScanningDevice();
        break;
      case ScreenState.deviceConnecting:
        break;
      case ScreenState.deviceConnected:
        break;
      case ScreenState.error:
      // TODO: Handle this case.
      default:
        break;
    }
  }
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * *       Extension for handling permission                * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

extension RequestPermissionExt on ConnectDeviceScreenBloc {
  void _handlePermission() async {
    final temp = state.copyWith();
    temp.screenState = ScreenState.checkPermission;
    temp.dialogState = DialogState.none;
    temp.connectedDevices = [];
    temp.foundDevices = [];
    temp.connectingDevice = null;
    emit(temp);

    final scanPermission = await PermissionUtils.checkScanPermission();
    switch (scanPermission) {
      case ScanStateEnum.granted:
        handleScreenState(ScreenState.checkBluetooth);
        break;
      case ScanStateEnum.bluetoothDenied:
        if (Platform.isIOS) {
          _handleDialogState(DialogState.requireBluetoothPermission);
          return;
        }
        if (!isBluetoothPermissionChecked) {
          print("_handlePermission bluetoothDenied");
          await PermissionUtils.requestBluetoothPermission();
          isBluetoothPermissionChecked = true;
          _handlePermission();
          return;
        }
        _handleDialogState(DialogState.requireBluetoothPermission);
        break;
      case ScanStateEnum.bluetoothPermanentlyDenied:
        if (Platform.isIOS) {
          _handleDialogState(DialogState.requireBluetoothPermission);
          return;
        }
        if (!isBluetoothPermissionChecked) {
          print("_handlePermission bluetoothPermanentlyDenied");
          await PermissionUtils.requestBluetoothPermission();
          isBluetoothPermissionChecked = true;
          _handlePermission();
          return;
        }
        _handleDialogState(DialogState.requireBluetoothPermission);
        break;
      case ScanStateEnum.locationDenied:
        if (!isLocationPermissionChecked) {
          await PermissionUtils.requestLocationPermission();
          isLocationPermissionChecked = true;
          _handlePermission();
          return;
        }
        _handleDialogState(DialogState.requireLocationPermission);
        break;
      case ScanStateEnum.locationPermanentlyDenied:
        if (!isLocationPermissionChecked) {
          await PermissionUtils.requestLocationPermission();
          isLocationPermissionChecked = true;
          _handlePermission();
          return;
        }
        _handleDialogState(DialogState.requireLocationPermission);
        break;
    }
  }
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * *                  BLUETOOTH AND LOCATION                * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

extension BluetoothAndLocationExt on ConnectDeviceScreenBloc {
  void _checkBluetoothState() async {
    emit(state.copyWith(screenState: ScreenState.checkBluetooth));

    final isBluetoothEnable = await DeviceCorePlugin.isBleEnabled();
    if (isBluetoothEnable) {
      handleScreenState(ScreenState.checkLocation);
    } else {
      _handleDialogState(DialogState.bluetoothNotAvailable);
    }
  }

  void _checkLocationState() async {
    state.screenState = ScreenState.checkLocation;
    bool serviceEnabled = await LocationService.isEnableForScanningBLe();
    // if location is enable go to scanning
    if (serviceEnabled) {
      handleScreenState(ScreenState.scanning);
      return;
    }

    // if location is not enable request location
    _timeout?.cancel();
    serviceEnabled = await LocationService.requestLocation();
    if (serviceEnabled) {
      handleScreenState(ScreenState.scanning);
      return;
    }

    // no location go to get Start
    _handleDialogState(DialogState.locationNotAvailable);
  }
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * *                  SCAN AND CONNECT                      * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

extension ScanAndConnectExt on ConnectDeviceScreenBloc {
  void _setupDeviceEventListener() async {
    _deviceEventListener?.cancel();
    _deviceEventListener = DeviceCorePlugin.listenEvent().listen((event) {
      switch (event.event) {
        case EventEnum.onDeviceFound:
          _handleFoundDevice(event);
          break;
        case EventEnum.onDeviceConnected:
          _handleDeviceConnected(event);
          break;
        case EventEnum.onDeviceDisconnected:
          _onConnectFailed(event);
          break;
        default:
          break;
      }
    });
  }

  void _handleFoundDevice(DeviceEventTask event) {
    final device = event.toScannedDevice();
    if (state.foundDevices.any((element) => element.address == device.address)) return;
    // add new device to current list
    emit(state.copyWith(foundDevices: [...state.foundDevices, device]));
  }

  void _handleDeviceConnected(DeviceEventTask event) async {
    final device = event.toConnectedDevice();
    if (state.connectingDevice?.address != device.address) return;

    _timeout?.cancel();

    final newState = state.copyWith();

    newState.connectingDevice = null;
    newState.connectedDevices = [...state.connectedDevices, device];
    newState.screenState = ScreenState.deviceConnected;
    newState.dialogState = DialogState.none;

    emit(newState);

    serviceLocator.get<GlobalBloc>().notifyGlobalChanges(ReloadParam(
          reloadState: ReloadState.onDeviceConnected,
          data: device,
          forceReload: true,
        ));
  }

  void _startScanningDevice() async {
    emit(state.copyWith(screenState: ScreenState.scanning));
    await DeviceCorePlugin.startScan();
  }

  void _stopScanningDevice() async {
    emit(state.copyWith(screenState: ScreenState.stopScanning));
    await DeviceCorePlugin.stopScan();
  }

  void connectDevice(FoundDevice device) {
    DeviceCorePlugin.connect(device.address);
    _startTimer(TimeOutEnum.pairingTimeOut.seconds, onConnectTimeout);
    emit(state.copyWith(
      screenState: ScreenState.deviceConnecting,
      connectingDevice: device,
      dialogState: DialogState.pairingDevice,
    ));
  }

  void disconnectDevice(FoundDevice device) {
    DeviceCorePlugin.disconnect(device.address);
  }

  void onConnectTimeout() {
    if (state.connectingDevice == null) return;
    DeviceCorePlugin.disconnect(state.connectingDevice?.address ?? '');
    emit(state.copyWith(screenState: ScreenState.error, dialogState: DialogState.pairingFailed));
  }

  void _onConnectFailed(DeviceEventTask event) {
    final device = event.toScannedDevice();
    if (state.connectingDevice == null || state.connectingDevice?.address != device.address) return;
    DeviceCorePlugin.disconnect(state.connectingDevice?.address ?? '');
    emit(state.copyWith(screenState: ScreenState.error, dialogState: DialogState.pairingFailed));
  }
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * *                       DIALOG                           * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

extension DialogExt on ConnectDeviceScreenBloc {
  void _handleDialogState(DialogState dialogState) {
    emit(state.copyWith(dialogState: dialogState));
  }

  void resetDialogState() {
    emit(state.copyWith(dialogState: DialogState.none));
  }
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * *                       BLUETOOTH                        * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
extension BluetoothExt on ConnectDeviceScreenBloc {
  void _setupBluetoothListener() {
    _bluetoothStateListener?.cancel();
    _bluetoothStateListener = BleStatePlugin.listenEvent().listen((event) {
      if (event == BluetoothState.off) {
        _handleDialogState(DialogState.bluetoothNotAvailable);
        return;
      }

      resetDialogState();
      handleScreenState(ScreenState.checkPermission);
    });
  }

  void pauseBluetoothListener() {
    _bluetoothStateListener?.pause();
  }

  void restartBluetoothListener() {
    if (_bluetoothStateListener != null && _bluetoothStateListener!.isPaused) {
      _bluetoothStateListener?.resume();
    }
  }
}

extension CommandExt on ConnectDeviceScreenBloc {
  void getDeviceInfo(FoundDevice device) {
    DeviceCorePlugin.getDeviceInfo(address: device.address);
  }

  void setStartStopStudy(FoundDevice device, bool startStop) {
    DeviceCorePlugin.setStartStopStudy(address: device.address, startStop: startStop);
  }
}