import 'package:flex_sense/plugin/device_core/models/imu/accel.dart';
import 'package:flex_sense/plugin/device_core/models/imu/gyros.dart';
import 'package:flex_sense/plugin/device_core/models/magnetic.dart';
import 'package:flex_sense/plugin/device_core/models/imu/roll_pitch_yaw.dart';
import 'package:flex_sense/plugin/device_core/models/pressure.dart';
import 'package:flex_sense/presentation/screens/device_detail/bloc/device_detail_bloc.dart';
import 'package:flex_sense/presentation/screens/device_detail/bloc/device_detail_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceDetailAccelSelector
    extends BlocSelector<DeviceDetailBloc, DeviceDetailState, List<Accel>> {
  DeviceDetailAccelSelector({
    super.key,
    required Widget Function(List<Accel> accels) builder,
  }) : super(
          selector: (state) => state.accelList,
          builder: (_, state) => builder(state),
        );
}

class DeviceDetailGyrosSelector
    extends BlocSelector<DeviceDetailBloc, DeviceDetailState, List<Gyros>> {
  DeviceDetailGyrosSelector({
    super.key,
    required Widget Function(List<Gyros> gyros) builder,
  }) : super(
          selector: (state) => state.gyrosList,
          builder: (_, state) => builder(state),
        );
}

class DeviceDetailRollPitchYawSelector
    extends BlocSelector<DeviceDetailBloc, DeviceDetailState, List<RollPitchYaw>> {
  DeviceDetailRollPitchYawSelector({
    super.key,
    required Widget Function(List<RollPitchYaw> rollPitchYaws) builder,
  }) : super(
          selector: (state) => state.rollPitchYawList,
          builder: (_, state) => builder(state),
        );
}

class DeviceDetailMagneticSelector
    extends BlocSelector<DeviceDetailBloc, DeviceDetailState, List<Magnetic>> {
  DeviceDetailMagneticSelector({
    super.key,
    required Widget Function(List<Magnetic> magnetics) builder,
  }) : super(
          selector: (state) => state.magneticList,
          builder: (_, state) => builder(state),
        );
}

class DeviceDetailPressureSelector
    extends BlocSelector<DeviceDetailBloc, DeviceDetailState, List<double>> {
  DeviceDetailPressureSelector({
    super.key,
    required Widget Function(List<double> pressures) builder,
  }) : super(
          selector: (state) => state.pressureVoltagesList,
          builder: (_, state) => builder(state),
        );
}

class DeviceDetailViewStoredAccelSelector
    extends BlocSelector<DeviceDetailBloc, DeviceDetailState, bool> {
  DeviceDetailViewStoredAccelSelector({
    super.key,
    required Widget Function(bool isLoading) builder,
  }) : super(
          selector: (state) => state.gettingLocalData == DeviceDetailGettingLocalData.imu,
          builder: (_, state) => builder(state),
        );
}

class DeviceDetailViewStoredMagneticSelector
    extends BlocSelector<DeviceDetailBloc, DeviceDetailState, bool> {
  DeviceDetailViewStoredMagneticSelector({
    super.key,
    required Widget Function(bool isLoading) builder,
  }) : super(
          selector: (state) => state.gettingLocalData == DeviceDetailGettingLocalData.magnetic,
          builder: (_, state) => builder(state),
        );
}

class DeviceDetailViewStoredPressureSelector
    extends BlocSelector<DeviceDetailBloc, DeviceDetailState, bool> {
  DeviceDetailViewStoredPressureSelector({
    super.key,
    required Widget Function(bool isLoading) builder,
  }) : super(
          selector: (state) => state.gettingLocalData == DeviceDetailGettingLocalData.pressure,
          builder: (_, state) => builder(state),
        );
}