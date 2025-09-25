import 'dart:async';

import 'package:flex_sense/data/data_source/local/drift/app_database.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/data/repository/imu_repo/imu_repo.dart';
import 'package:flex_sense/data/repository/magnetic_repo/magnetic_repo.dart';
import 'package:flex_sense/data/repository/pressure_repo/pressure_repo.dart';
import 'package:flex_sense/plugin/device_core/device_core_plugin.dart';
import 'package:flex_sense/plugin/device_core/device_event_task.dart';
import 'package:flex_sense/plugin/device_core/enum/event_enum.dart';
import 'package:flex_sense/plugin/device_core/models/connected_device.dart';
import 'package:flex_sense/presentation/base_bloc/base_cubit.dart';
import 'package:flex_sense/presentation/globals/global_states/global/global_bloc.dart';
import 'package:flex_sense/presentation/globals/global_states/global/global_state.dart';
import 'package:flex_sense/presentation/screens/device_detail/bloc/device_detail_state.dart';

class DeviceDetailBloc extends BaseCubit<DeviceDetailState> {
  DeviceDetailBloc()
      : super(DeviceDetailState(
          accelList: [],
          gyrosList: [],
          magneticList: [],
          pressureVoltagesList: [],
        ));

  final _maxDataSize = 50;

  StreamSubscription<DeviceEventTask?>? _deviceEventListener;
  StreamSubscription? _reloadStreamSub;

  void initState(ConnectedDevice device) {
    emit(state.copyWith(device: device));
    _setupDeviceEventListener();
    _subscribeReloadStream();
  }

  @override
  Future<void> close() {
    _deviceEventListener?.cancel();
    _reloadStreamSub?.cancel();
    return super.close();
  }

  void _subscribeReloadStream() {
    _reloadStreamSub?.cancel();
    _reloadStreamSub = serviceLocator.get<GlobalBloc>().listenGlobalChanges().listen((event) async {
      print('DeviceDetailBloc: _subscribeReloadStream: event: $event');
      switch (event.reloadState) {
        case ReloadState.onDeviceDisconnected:
          _onDeviceDisconnected(event.data as ConnectedDevice);
          break;
        default:
          break;
      }
    });
  }

  void _onDeviceDisconnected(ConnectedDevice device) {
    if (state.device!.address != device.address) {
      return;
    }

    final tempState = state.copyWith();
    tempState.device = null;
    emit(tempState);
  }

  void getDeviceInfo() {
    DeviceCorePlugin.getDeviceInfo(address: state.device!.address);
  }

  Future<void> setStartStopStudy(bool startStop) async {
    await DeviceCorePlugin.setStartStopStudy(address: state.device!.address, startStop: startStop);
  }

  void getTimeStamp() {
    DeviceCorePlugin.getTimeStamp(address: state.device!.address);
  }

  void setTimeStamp(DateTime timeStamp) {
    DeviceCorePlugin.setTimeStamp(address: state.device!.address, timeStamp: timeStamp);
  }

  void getErrorCode() {
    DeviceCorePlugin.getErrorCode(address: state.device!.address);
  }

  void getBatteryInfo() {
    DeviceCorePlugin.getBatteryInfo(address: state.device!.address);
  }

  void _setupDeviceEventListener() async {
    _deviceEventListener?.cancel();
    _deviceEventListener = DeviceCorePlugin.listenEvent().listen((task) {
      if (task.data['address'] != state.device!.address) {
        return;
      }

      switch (task.event) {
        case EventEnum.onDeviceInfoRsp:
          _updateDeviceInfo(task);
          break;
        case EventEnum.onTimeStampRsp:
          _updateTimeStamp(task);
          break;
        case EventEnum.onErrorCodeRsp:
          _updateErrorCode(task);
          break;
        case EventEnum.onBatteryInfoRsp:
          _updateBatteryInfo(task);
          break;
        case EventEnum.onImuNotified:
          _updateImu(task);
          break;
        case EventEnum.onMagNotified:
          _updateMagnetic(task);
          break;
        case EventEnum.onPressureNotified:
          _updatePressure(task);
          break;
        default:
          break;
      }
    });
  }

  void _updateDeviceInfo(DeviceEventTask task) {
    emit(state.copyWith(deviceInfo: task.toDeviceInfo()));
  }

  void _updateTimeStamp(DeviceEventTask task) {
    emit(state.copyWith(timeStamp: task.toTimeStamp()));
  }

  void _updateErrorCode(DeviceEventTask task) {
    emit(state.copyWith(errorCode: task.toErrorCode()));
  }

  void _updateBatteryInfo(DeviceEventTask task) {
    emit(state.copyWith(batteryInfo: task.toBatteryInfo()));
  }

  void _updateImu(DeviceEventTask task) {
    final newImuList = task.toImuListView(task.toTimeStamp().time);

    final newAccList = newImuList.map((e) => e.accel).toList();
    final newGyrosList = newImuList.map((e) => e.gyros).toList();

    final accList = [...state.accelList, ...newAccList];
    final gyrosList = [...state.gyrosList, ...newGyrosList];

    // Ensure the list does not exceed the maximum size
    if (accList.length > _maxDataSize) {
      // Remove elements from the beginning
      int itemsToRemove = accList.length - _maxDataSize;
      accList.removeRange(0, itemsToRemove);
    }

    if (gyrosList.length > _maxDataSize) {
      // Remove elements from the beginning
      int itemsToRemove = gyrosList.length - _maxDataSize;
      gyrosList.removeRange(0, itemsToRemove);
    }

    emit(state.copyWith(
      accelList: accList,
      gyrosList: gyrosList,
    ));
  }

  void _updateMagnetic(DeviceEventTask task) {
    final newMagneticList = task.toMagneticListView(task.toTimeStamp().time);
    final magneticList = [...state.magneticList, ...newMagneticList];

    // Ensure the list does not exceed the maximum size
    if (magneticList.length > _maxDataSize) {
      // Remove elements from the beginning
      int itemsToRemove = magneticList.length - _maxDataSize;
      magneticList.removeRange(0, itemsToRemove);
    }

    emit(state.copyWith(magneticList: magneticList));
  }

  void _updatePressure(DeviceEventTask task) {
    final newPressureVoltageList = task.toPressure().voltages;
    final pressureVoltagesList = [...state.pressureVoltagesList, ...newPressureVoltageList];

    // Ensure the list does not exceed the maximum size
    if (pressureVoltagesList.length > _maxDataSize) {
      // Remove elements from the beginning
      int itemsToRemove = pressureVoltagesList.length - _maxDataSize;
      pressureVoltagesList.removeRange(0, itemsToRemove);
    }

    emit(state.copyWith(pressureVoltagesList: pressureVoltagesList));
  }

  void disconnectDevice(ConnectedDevice device) {
    DeviceCorePlugin.disconnect(device.address);
  }

  Future<List<ImuEntityData>> onPressViewStoredImuData() async {
    emit(state.copyWith(gettingLocalData: DeviceDetailGettingLocalData.imu));

    final imus = await serviceLocator.get<ImuRepo>().getLatest(limit: 100).get();

    emit(state.copyWith(gettingLocalData: DeviceDetailGettingLocalData.none));

    return imus;
  }

  Future<List<dynamic>> onPressViewStoredMagneticData() async {
    emit(state.copyWith(gettingLocalData: DeviceDetailGettingLocalData.magnetic));

    final magnetic = await serviceLocator.get<MagneticRepo>().getLatest(limit: 100).get();

    emit(state.copyWith(gettingLocalData: DeviceDetailGettingLocalData.none));

    return magnetic;
  }

  Future<List<PressureEntityData>> onPressViewStoredPressureData() async {
    emit(state.copyWith(gettingLocalData: DeviceDetailGettingLocalData.pressure));

    final pressures = await serviceLocator.get<PressureRepo>().getLatest(limit: 100).get();

    emit(state.copyWith(gettingLocalData: DeviceDetailGettingLocalData.none));

    return pressures;
  }
}
