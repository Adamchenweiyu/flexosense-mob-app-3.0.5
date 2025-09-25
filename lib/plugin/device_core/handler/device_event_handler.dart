import 'dart:async';

import 'package:flex_sense/plugin/device_core/device_event_task.dart';

class DeviceEventHandler {
  static final listeners = StreamController<DeviceEventTask>.broadcast();

  static void handle({DeviceEventTask? data}) async {
    if (data == null) {
      return;
    }
    listeners.add(data);
  }
}