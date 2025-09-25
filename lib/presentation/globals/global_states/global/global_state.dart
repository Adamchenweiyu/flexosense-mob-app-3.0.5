// ignore_for_file: public_member_api_docs, sort_constructors_first
enum ReloadState {
  none,
  onDevicesUpdate,
  onDeviceConnected,
  onDeviceDisconnected,

  // use for update ui when open app -> reconnect device
  reconnectingDevice,
}

class GlobalState {
  String? userId;

  GlobalState({
    this.userId,
  });

  GlobalState copyWith({
    String? userId,
  }) {
    return GlobalState(
      userId: userId ?? this.userId,
    );
  }
}
