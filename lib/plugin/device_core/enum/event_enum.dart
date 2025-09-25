/// Make sure the event value matches the DeviceCoreEvent on Android/iOS native side
enum EventEnum {
  // Connection
  onDeviceFound,
  onDeviceConnected,
  onDeviceDisconnected,

  // Data Response
  onDeviceInfoRsp,
  onTimeStampRsp,
  onErrorCodeRsp,
  onBatteryInfoRsp,

  // Streaming data
  onImuNotified,
  onMagNotified,
  onPressureNotified;

  static EventEnum? from(String value) {
    switch (value) {
      // Connection
      case 'onDeviceFound':
        return EventEnum.onDeviceFound;
      case 'onDeviceConnected':
        return EventEnum.onDeviceConnected;
      case 'onDeviceDisconnected':
        return EventEnum.onDeviceDisconnected;

      // Data Response
      case 'onDeviceInfoRsp':
        return EventEnum.onDeviceInfoRsp;
      case 'onTimeStampRsp':
        return EventEnum.onTimeStampRsp;
      case 'onErrorCodeRsp':
        return EventEnum.onErrorCodeRsp;
      case 'onBatteryInfoRsp':
        return EventEnum.onBatteryInfoRsp;

      // Notified data
      case 'onImuNotified':
        return EventEnum.onImuNotified;
      case 'onMagNotified':
        return EventEnum.onMagNotified;
      case 'onPressureNotified':
        return EventEnum.onPressureNotified;
      default:
        return null;
    }
  }
}
