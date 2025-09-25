import 'package:flex_sense/plugin/device_core/models/connected_device.dart';
import 'package:flex_sense/presentation/screens/home/bloc/home_screen_bloc.dart';
import 'package:flex_sense/presentation/screens/home/bloc/home_screen_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBlocSelector
    extends BlocSelector<HomeScreenBloc, HomeScreenState, List<ConnectedDevice>> {
  HomeScreenBlocSelector({
    super.key,
    required Widget Function(List<ConnectedDevice> connectedDevices) builder,
  }) : super(
          selector: (state) => state.connectedDevices,
          builder: (_, state) => builder(state),
        );
}
