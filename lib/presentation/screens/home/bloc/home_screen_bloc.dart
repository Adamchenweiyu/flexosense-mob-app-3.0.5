import 'dart:async';

import 'package:flex_sense/presentation/base_bloc/base_cubit.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/plugin/device_core/models/connected_device.dart';
import 'package:flex_sense/presentation/globals/global_states/global/global_bloc.dart';
import 'package:flex_sense/presentation/globals/global_states/global/global_state.dart';
import 'package:flex_sense/presentation/screens/home/bloc/home_screen_state.dart';

class HomeScreenBloc extends BaseCubit<HomeScreenState> {
  HomeScreenBloc()
      : super(HomeScreenState(
          connectedDevices: [],
        ));

  StreamSubscription? _reloadStreamSub;

  void initState() {
    _subscribeReloadStream();
  }

  @override
  Future<void> close() {
    _reloadStreamSub?.cancel();
    return super.close();
  }

  void _subscribeReloadStream() {
    _reloadStreamSub?.cancel();
    _reloadStreamSub = serviceLocator.get<GlobalBloc>().listenGlobalChanges().listen((event) async {
      print('HomeScreenBloc: _subscribeReloadStream: event: $event');
      switch (event.reloadState) {
        case ReloadState.onDeviceConnected:
          _onNewDeviceConnected(event.data as ConnectedDevice);
          break;
        case ReloadState.onDeviceDisconnected:
          _onDeviceDisconnected(event.data as ConnectedDevice);
          break;
        default:
          break;
      }
    });
  }

  void _onNewDeviceConnected(ConnectedDevice device) {
    if (state.connectedDevices.any((element) => element.address == device.address)) {
      return;
    }

    emit(state.copyWith(
      connectedDevices: [...state.connectedDevices, device],
    ));
  }

  void _onDeviceDisconnected(ConnectedDevice device) {
    emit(state.copyWith(
      connectedDevices: state.connectedDevices.where((element) => element.address != device.address).toList(),
    ));
  }

  // Future<List<dynamic>> onPressViewStoredAccelData() async {
  //   final acc = await serviceLocator.get<AccelRepo>().getLatest(limit: 100).get();
  //   return acc;
  // }
}
