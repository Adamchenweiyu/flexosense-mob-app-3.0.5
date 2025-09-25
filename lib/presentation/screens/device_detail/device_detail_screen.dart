import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/plugin/device_core/models/connected_device.dart';
import 'package:flex_sense/presentation/navigation/app_navigation.dart';
import 'package:flex_sense/presentation/navigation/app_routes.dart';
import 'package:flex_sense/presentation/screens/device_detail/bloc/device_detail_bloc.dart';
import 'package:flex_sense/presentation/screens/device_detail/bloc/device_detail_bloc_listener.dart';
import 'package:flex_sense/presentation/screens/device_detail/bloc/device_detail_bloc_selector.dart';
import 'package:flex_sense/presentation/screens/device_detail/bloc/device_detail_state.dart';
import 'package:flex_sense/presentation/widgets/commons/app_bar/custom_app_bar.dart';
import 'package:flex_sense/presentation/widgets/commons/button/filled_button.dart';
import 'package:flex_sense/presentation/widgets/commons/dialog/custom_dialog.dart';
import 'package:flex_sense/presentation/widgets/specifics/live_data_bottom_sheet.dart';
import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/fonts/app_font.dart';
import 'package:flex_sense/application/resource/images/app_images.dart';
import 'package:flex_sense/application/resource/strings/app_strings.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flex_sense/application/resource/value_manager.dart';
import 'package:flex_sense/presentation/widgets/specifics/live_pressure_bottom_sheet.dart';
import 'package:flex_sense/presentation/widgets/specifics/stored_data_bottom_sheet.dart';
import 'package:flex_sense/presentation/widgets/specifics/stored_magnetic_bottom_sheet.dart';
import 'package:flex_sense/presentation/widgets/specifics/stored_pressure_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DeviceDetailScreen extends StatefulWidget {
  const DeviceDetailScreen({super.key});

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  final _bloc = serviceLocator.get<DeviceDetailBloc>();
  var inited = false;
  late ConnectedDevice _device;
  
  bool _isStudyStarted = false;

  @override
  void didChangeDependencies() {
    if (!inited) {
      _device = ModalRoute.of(context)!.settings.arguments as ConnectedDevice;
      _bloc.initState(_device);
      inited = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isStudyStarted = true;
        });
        _bloc.setStartStopStudy(true);
      });
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onDeviceInfoUpdated(BuildContext context, DeviceDetailState state) {
    AppNavigation.popUntil(context, AppRoutes.deviceDetail);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomDialog(
          imageHeight: SizeApp.s52,
          title: AppStrings.deviceInfo,
          message: '${AppStrings.deviceName}: ${state.deviceInfo?.deviceName ?? '-'}\n ' +
              '${AppStrings.deviceAddress}: ${state.deviceInfo?.deviceAddress ?? '-'}\n ' +
              '${AppStrings.hwVersion}: ${state.deviceInfo?.hwVersion ?? '-'}\n ' +
              '${AppStrings.fwVersion}: ${state.deviceInfo?.fwVersion ?? '-'}\n ',
          positiveButtonText: AppStrings.ok,
          onPressPositiveButton: () {
            AppNavigation.pop(context);
          },
        );
      },
    );
  }

  void _onTimeStampUpdated(BuildContext context, DeviceDetailState state) {
    AppNavigation.popUntil(context, AppRoutes.deviceDetail);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomDialog(
          imageHeight: SizeApp.s52,
          title: AppStrings.timestamp,
          message: '${AppStrings.timestamp}: ${state.timeStamp?.time}\n ',
          positiveButtonText: AppStrings.ok,
          onPressPositiveButton: () {
            AppNavigation.pop(context);
          },
        );
      },
    );
  }

  void _onErrorCodeUpdated(BuildContext context, DeviceDetailState state) {
    AppNavigation.popUntil(context, AppRoutes.deviceDetail);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomDialog(
          imageHeight: SizeApp.s52,
          title: AppStrings.errorCode,
          message: '${AppStrings.imuSensor}: ${state.errorCode?.imuSensor ?? '-'}\n ' +
              '${AppStrings.magSensor}: ${state.errorCode?.magSensor ?? '-'}\n ' +
              '${AppStrings.batteryMonitor}: ${state.errorCode?.batteryMonitor ?? '-'}\n ' + 
              '${AppStrings.pressureSensor}: ${state.errorCode?.pressureSensor ?? '-'}\n ' +
              '${AppStrings.wrongSide}: ${state.errorCode?.wrongSide ?? '-'}\n ',
          positiveButtonText: AppStrings.ok,
          onPressPositiveButton: () {
            AppNavigation.pop(context);
          },
        );
      },
    );
  }

  void _onBatteryInfoUpdated(BuildContext context, DeviceDetailState state) {
    AppNavigation.popUntil(context, AppRoutes.deviceDetail);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomDialog(
          imageHeight: SizeApp.s52,
          title: AppStrings.batteryInfo,
          message: '${AppStrings.isCharging}: ${state.batteryInfo?.isCharging ?? '-'}\n ' +
              '${AppStrings.batteryLevel}: ${state.batteryInfo?.level ?? '-'}\n ' +
              '${AppStrings.voltage}: ${state.batteryInfo?.voltage ?? '-'}\n ',
          positiveButtonText: AppStrings.ok,
          onPressPositiveButton: () {
            AppNavigation.pop(context);
          },
        );
      },
    );
  }

  void _onDeviceDisconnected(BuildContext context, DeviceDetailState state) {
    AppNavigation.popUntil(context, AppRoutes.deviceDetail);
    setState(() {
      _isStudyStarted = false;
    });
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomDialog(
          imageHeight: SizeApp.s52,
          title: AppStrings.disconnect,
          message: '${AppStrings.deviceName}: ${state.device?.name ?? '-'}\n ' +
              '${AppStrings.deviceAddress}: ${state.device?.address ?? '-'}\n ',
          positiveButtonText: AppStrings.ok,
          onPressPositiveButton: () {
            AppNavigation.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: MultiBlocListener(
        listeners: [
          DeviceDetailDeviceInfoListener(listener: _onDeviceInfoUpdated),
          DeviceDetailTimestampListener(listener: _onTimeStampUpdated),
          DeviceDetailErrorCodeListener(listener: _onErrorCodeUpdated),
          DeviceDetailBatteryInfoListener(listener: _onBatteryInfoUpdated),
          DeviceDisConnectedListener(listener: _onDeviceDisconnected),
        ],
        child: Scaffold(
          appBar: _buildAppBar(),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildMethod(),
          ),
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      leadingWidget: IconButton(
        icon: Icon(Icons.close, color: AppColors.black1),
        onPressed: () => AppNavigation.pop(context),
      ),
      titleWidget: Text(
        AppStrings.deviceDetail,
        style: AppTextStyles.semiBold(color: AppColors.blackSecondary, fontSize: AppFontSize.s20),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMethod() {
    final isCharger = _device.name?.contains('FEET-CHARGER') ?? false;

    List<Widget> chargerButtons = [
      FilledButtonApp(
        label: AppStrings.getBatteryInfo,
        onPressed: () => _bloc.getBatteryInfo(),
      ),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.disconnect,
        onPressed: _onPressDisconnect,
      ),
    ];

    List<Widget> sensorButtons = [
      FilledButtonApp(
        label: AppStrings.setStartStopStudy,
        color: _isStudyStarted ? Colors.red : Colors.green,
        onPressed: () {
          setState(() {
            _isStudyStarted = !_isStudyStarted;
          });
          _bloc.setStartStopStudy(_isStudyStarted);
        },
      ),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.getDeviceInfo,
        onPressed: () => _bloc.getDeviceInfo(),
      ),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.getTimeStamp,
        onPressed: () => _bloc.getTimeStamp(),
      ),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.setTimeStamp,
        onPressed: () => _bloc.setTimeStamp(DateTime.now()),
      ),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.getErrorCode,
        onPressed: () => _bloc.getErrorCode(),
      ),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.getBatteryInfo,
        onPressed: () => _bloc.getBatteryInfo(),
      ),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.liveAccelData,
        onPressed: _onPressLiveAccelData,
      ),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.liveGyrosData,
        onPressed: _onPressLiveGyrosData,
      ),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.liveRawPitchYawData,
        onPressed: _onPressLiveRollPitchYawData,
      ),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.liveMagneticData,
        onPressed: _onPressLiveMagneticData,
      ),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.livePressureData,
        onPressed: _onPressLivePressureData,
      ),
      const SizedBox(height: 16),
      _buildViewStoredImu(),
      const SizedBox(height: 16),
      _buildViewStoredMagnetic(),
      const SizedBox(height: 16),
      _buildViewStoredPressure(),
      const SizedBox(height: 16),
      FilledButtonApp(
        label: AppStrings.disconnect,
        onPressed: _onPressDisconnect,
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: isCharger ? chargerButtons : sensorButtons,
      ),
    );
  }

  void _onPressLiveAccelData() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: BlocProvider.value(
          value: _bloc,
          child: DeviceDetailAccelSelector(
            builder: (data) => LiveDataBottomSheet(
              title: AppStrings.liveAccelData,
              data: data,
            ),
          ),
        ),
      ),
    );
  }

  void _onPressLiveGyrosData() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: BlocProvider.value(
          value: _bloc,
          child: DeviceDetailGyrosSelector(
            builder: (data) => LiveDataBottomSheet(
              title: AppStrings.liveGyrosData,
              data: data,
            ),
          ),
        ),
      ),
    );
  }

  void _onPressLiveRollPitchYawData() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: BlocProvider.value(
          value: _bloc,
          child: DeviceDetailRollPitchYawSelector(
            builder: (data) => LiveDataBottomSheet(
              title: AppStrings.liveRawPitchYawData,
              data: data,
              isRollPitchYaw: true,
            ),
          ),
        ),
      ),
    );
  }

  void _onPressLiveMagneticData() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: BlocProvider.value(
          value: _bloc,
          child: DeviceDetailMagneticSelector(
            builder: (data) => LiveDataBottomSheet(
              title: AppStrings.liveMagneticData,
              data: data,
            ),
          ),
        ),
      ),
    );
  }

  void _onPressLivePressureData() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: BlocProvider.value(
          value: _bloc,
          child: DeviceDetailPressureSelector(
            builder: (data) => LivePressureBottomSheet(
              title: AppStrings.livePressureData,
              data: data,
            ),
          ),
        ),
      ),
    );
  }

  void _onPressDisconnect() async {
    await _bloc.setStartStopStudy(false);
    setState(() {
      _isStudyStarted = false;
    });
    _bloc.disconnectDevice(_bloc.state.device!);
  }

  Widget _buildViewStoredImu() {
    return DeviceDetailViewStoredAccelSelector(
      builder: (isLoading) => Stack(
        children: [
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.semanticGreen),
            onPressed: _onPressViewStoredImu,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('View stored IMU'),
                const SizedBox(width: 8),
                const Icon(Icons.view_agenda),
              ],
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: AppColors.black1.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onPressViewStoredImu() async {
    final data = await _bloc.onPressViewStoredImuData();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: StoredDataBottomSheet(
          title: 'View stored IMU',
          data: data,
        ),
      ),
    );
  }

  Widget _buildViewStoredMagnetic() {
    return DeviceDetailViewStoredMagneticSelector(
      builder: (isLoading) => Stack(
        children: [
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.semanticGreen),
            onPressed: _onPressViewStoredMagnetic,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppStrings.viewStoredMagnetic),
                const SizedBox(width: 8),
                const Icon(Icons.view_agenda),
              ],
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: AppColors.black1.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onPressViewStoredMagnetic() async {
    final data = await _bloc.onPressViewStoredMagneticData();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: StoredMagneticBottomSheet(
          title: AppStrings.viewStoredMagnetic,
          data: data,
        ),
      ),
    );
  }

  Widget _buildViewStoredPressure() {
    return DeviceDetailViewStoredPressureSelector(builder: 
      (isLoading) => Stack(
        children: [
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.semanticGreen),
            onPressed: _onPressViewStoredPressure,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppStrings.viewStoredPressure),
                const SizedBox(width: 8),
                const Icon(Icons.view_agenda),
              ],
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: AppColors.black1.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onPressViewStoredPressure() async {
    final data = await _bloc.onPressViewStoredPressureData();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: StoredPressureBottomSheet(
          title: AppStrings.viewStoredPressure,
          data: data,
        ),
      ),
    );
  }
}
