// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flex_sense/plugin/device_core/models/connected_device.dart';

class HomeScreenState {
  List<ConnectedDevice> connectedDevices;
  
  HomeScreenState({
    required this.connectedDevices,
  });

  HomeScreenState copyWith({
    List<ConnectedDevice>? connectedDevices,
  }) {
    return HomeScreenState(
      connectedDevices: connectedDevices ?? this.connectedDevices,
    );
  }
}
