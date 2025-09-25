import 'dart:async';

import 'package:flex_sense/application/constants/ble_constant.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/data/repository/imu_repo/imu_repo.dart';
import 'package:flex_sense/data/repository/magnetic_repo/magnetic_repo.dart';
import 'package:flex_sense/data/repository/pressure_repo/pressure_repo.dart';
import 'package:flex_sense/data/service/database_queue_service.dart';
import 'package:flex_sense/plugin/device_core/device_core_plugin.dart';
import 'package:flex_sense/plugin/device_core/device_event_task.dart';
import 'package:flex_sense/plugin/device_core/enum/event_enum.dart';
import 'package:flex_sense/presentation/base_bloc/base_cubit.dart';
import 'package:flex_sense/presentation/globals/global_states/global/global_state.dart';
import 'package:flex_sense/presentation/globals/global_states/global/reload_param.dart';
import 'package:flex_sense/plugin/device_core/models/imu/imu.dart';
import 'package:flex_sense/plugin/device_core/models/magnetic.dart';

class GlobalBloc extends BaseCubit<GlobalState> {
  GlobalBloc() : super(GlobalState());
  final _reloadStream = StreamController<ReloadParam>.broadcast();
  StreamSubscription<DeviceEventTask?>? _deviceEventListener;

  @override
  Future<void> close() {
    _reloadStream.close();
    _deviceEventListener?.cancel();
    return super.close();
  }

  //************************ GLOBAL CHANGES ****************************** */
  Stream<ReloadParam> listenGlobalChanges() {
    return _reloadStream.stream;
  }

  void notifyGlobalChanges(ReloadParam param) {
    return _reloadStream.add(param);
  }

  void subscribeDeviceEventListener() {
    _deviceEventListener?.cancel();
    _deviceEventListener = DeviceCorePlugin.listenEvent().listen((task) {
      switch (task.event) {
        case EventEnum.onImuNotified:
          _saveImu(task);
          break;
        case EventEnum.onMagNotified:
          _saveMagnetic(task);
          break;
        case EventEnum.onPressureNotified:
          _savePressure(task);
          break;
        case EventEnum.onDeviceDisconnected:
          _onDeviceDisconnected(task);
          break;
        default:
          break;
      }
    });
  }

  void _saveImu(DeviceEventTask task) {
    final newImuList = task.toImuListSave(task.toTimeStamp().time);
    final newImuEntities = newImuList.map((e) => e.toImuEntityData()).toList();

    // Use queue service for safe database operations
    serviceLocator.get<DatabaseQueueService>().queueImuData(
      newImuEntities,
      deviceAddress: newImuList.isNotEmpty ? newImuList.first.address : null,
    );
  }

  void _saveMagnetic(DeviceEventTask task) {
    final newMagneticList = task.toMagneticListSave(task.toTimeStamp().time);

    final newMagneticEntities = newMagneticList.map((e) => e.toMagneticEntityData()).toList();
    
    // Use queue service for safe database operations
    serviceLocator.get<DatabaseQueueService>().queueMagneticData(
      newMagneticEntities,
      deviceAddress: newMagneticList.isNotEmpty ? newMagneticList.first.address : null,
    );
  }

  void _savePressure(DeviceEventTask task) {
    final newPressure = task.toPressure();

    final newPressureEntity = newPressure.toPressureEntityData();
    
    // Use queue service for safe database operations
    serviceLocator.get<DatabaseQueueService>().queuePressureData(
      newPressureEntity,
      deviceAddress: newPressure.address,
    );
  }

  void _onDeviceDisconnected(DeviceEventTask task) {
    Magnetic.resetTime();
    Imu.resetTime();

    final device = task.toConnectedDevice();

    serviceLocator.get<GlobalBloc>().notifyGlobalChanges(ReloadParam(
          reloadState: ReloadState.onDeviceDisconnected,
          data: device,
          forceReload: true,
        ));
  }

  void saveUserId(String userId) {
    emit(state.copyWith(userId: userId));
  }
}
