import 'package:flex_sense/presentation/screens/connect_device/bloc/connect_device_screen_bloc.dart';
import 'package:flex_sense/presentation/screens/connect_device/bloc/connect_device_screen_state.dart';
import 'package:flex_sense/presentation/screens/connect_device/found_device_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectDeviceScreenFoundCardSelector
    extends BlocBuilder<ConnectDeviceScreenBloc, ConnectDeviceScreenState> {
  ConnectDeviceScreenFoundCardSelector({
    super.key,
    required Widget Function(FoundDeviceCardType foundCardType) builder,
    required String deviceAddress,
  }) : super(
          buildWhen: (previous, current) =>
              previous.connectedDevices != current.connectedDevices ||
              previous.connectingDevice != current.connectingDevice,
          builder: (_, state) {
            if (state.connectedDevices.any((device) => device.address == deviceAddress)) {
              return builder(FoundDeviceCardType.connected);
            }

            if (state.connectingDevice?.address == deviceAddress) {
              return builder(FoundDeviceCardType.connecting);
            }

            return builder(FoundDeviceCardType.found);
          },
        );
}
