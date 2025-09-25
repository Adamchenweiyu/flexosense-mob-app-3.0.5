import 'package:flex_sense/presentation/globals/global_states/global/global_state.dart';

class ReloadParam {
  ReloadState reloadState;
  dynamic data;
  bool forceReload;

  ReloadParam({
    this.reloadState = ReloadState.none,
    this.data,
    this.forceReload = false,
  });

  ReloadParam copyWith({
    ReloadState? reloadState,
    dynamic data,
    bool? forceReload,
  }) {
    return ReloadParam(
      reloadState: reloadState ?? this.reloadState,
      data: data ?? this.data,
      forceReload: forceReload ?? this.forceReload,
    );
  }
}
