import 'package:flex_sense/presentation/screens/device_detail/bloc/device_detail_bloc.dart';
import 'package:flex_sense/presentation/screens/device_detail/bloc/device_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceDetailDeviceInfoListener extends BlocListener<DeviceDetailBloc, DeviceDetailState> {
  DeviceDetailDeviceInfoListener({
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.deviceInfo != currentState.deviceInfo,
        );
}

class DeviceDetailTimestampListener extends BlocListener<DeviceDetailBloc, DeviceDetailState> {
  DeviceDetailTimestampListener({
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.timeStamp != currentState.timeStamp,
        );
}

class DeviceDetailErrorCodeListener extends BlocListener<DeviceDetailBloc, DeviceDetailState> {
  DeviceDetailErrorCodeListener({
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.errorCode != currentState.errorCode,
        );
}

class DeviceDetailBatteryInfoListener extends BlocListener<DeviceDetailBloc, DeviceDetailState> {
  DeviceDetailBatteryInfoListener({
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.batteryInfo != currentState.batteryInfo,
        );
}

class DeviceDetailAccelListener extends BlocListener<DeviceDetailBloc, DeviceDetailState> {
  DeviceDetailAccelListener({
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.accelList != currentState.accelList,
        );
}

class DeviceDisConnectedListener extends BlocListener<DeviceDetailBloc, DeviceDetailState> {
  DeviceDisConnectedListener({
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) => previousState.device != currentState.device,
        );
}
