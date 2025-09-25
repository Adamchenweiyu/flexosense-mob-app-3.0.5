/// Make sure the method value matches the DeviceCoreMethod on Android/iOS native side
enum MethodEnum {
  // Permission
  isBleEnabled('isBleEnabled'),
  hasBlePermission('hasBlePermission'),

  // Scanning
  startScan('startScan'),
  stopScan('stopScan'),

  // Connection
  connect('connect'),
  disconnect('disconnect'),
  reconnect('reconnect'),
  reconnectDevices('reconnectDevices'),

  // Device commands
  getDeviceInfo('getDeviceInfo'),
  setStartStopStudy('setStartStopStudy'),
  setTimeStamp('setTimeStamp'),
  getTimeStamp('getTimeStamp'),
  getErrorCode('getErrorCode'),
  getBatteryInfo('getBatteryInfo');

  final String value;
  const MethodEnum(this.value);
}
