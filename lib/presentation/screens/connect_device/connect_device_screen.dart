import 'package:app_settings/app_settings.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/plugin/device_core/models/connected_device.dart';
import 'package:flex_sense/plugin/device_core/models/found_device.dart';
import 'package:flex_sense/presentation/navigation/app_navigation.dart';
import 'package:flex_sense/presentation/navigation/app_routes.dart';
import 'package:flex_sense/presentation/screens/connect_device/bloc/connect_device_screen_selector.dart';
import 'package:flex_sense/presentation/screens/connect_device/connecing_device_dialog.dart';
import 'package:flex_sense/presentation/screens/connect_device/bloc/connect_device_screen_bloc.dart';
import 'package:flex_sense/presentation/screens/connect_device/bloc/connect_device_screen_state.dart';
import 'package:flex_sense/presentation/widgets/commons/app_bar/custom_app_bar.dart';
import 'package:flex_sense/presentation/widgets/commons/button/filled_button.dart';
import 'package:flex_sense/presentation/screens/connect_device/found_device_card.dart';
import 'package:flex_sense/presentation/widgets/commons/button/outline_button.dart';
import 'package:flex_sense/presentation/widgets/commons/dialog/custom_dialog.dart';
import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/fonts/app_font.dart';
import 'package:flex_sense/application/resource/images/app_images.dart';
import 'package:flex_sense/application/resource/strings/app_strings.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flex_sense/application/resource/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ConnectingDeviceScreen extends StatefulWidget {
  const ConnectingDeviceScreen({super.key});

  @override
  State<ConnectingDeviceScreen> createState() => _ConnectingDeviceScreenState();
}

class _ConnectingDeviceScreenState extends State<ConnectingDeviceScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _bloc = serviceLocator.get<ConnectDeviceScreenBloc>();
  late AnimationController _btScanController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.initState();
    });
    WidgetsBinding.instance.addObserver(this);

    _btScanController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _btScanController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _bloc.close();
    _btScanController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _bloc.restartBluetoothListener();
        _handleResumedState();
        break;
      case AppLifecycleState.paused:
        _bloc.pauseBluetoothListener();
        break;
      default:
        break;
    }
  }

  void _handleResumedState() async {
    switch (_bloc.state.screenState) {
      case ScreenState.checkPermission:
      case ScreenState.checkBluetooth:
        AppNavigation.popUntil(context, AppRoutes.connectingDevice);
        _bloc.handleScreenState(ScreenState.checkPermission);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider.value(
        value: _bloc,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: BlocConsumer<ConnectDeviceScreenBloc, ConnectDeviceScreenState>(
            listenWhen: (previous, current) =>
                previous.screenState != current.screenState ||
                previous.dialogState != current.dialogState,
            listener: (ctx, state) {
              _handleListener(state);
            },
            buildWhen: (previous, current) => previous.screenState != current.screenState,
            builder: (ctx, state) {
              switch (state.screenState) {
                case ScreenState.none:
                case ScreenState.checkPermission:
                case ScreenState.checkBluetooth:
                case ScreenState.checkLocation:
                case ScreenState.error:
                case ScreenState.scanning:
                case ScreenState.stopScanning:
                case ScreenState.deviceConnecting:
                case ScreenState.deviceConnected:
                  return _buildBody();
              }
            },
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
        AppStrings.scanningYourDevices,
        style: AppTextStyles.semiBold(color: AppColors.blackSecondary, fontSize: AppFontSize.s20),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _handleListener(ConnectDeviceScreenState state) {
    if (!mounted) {
      return;
    }

    AppNavigation.popUntil(context, AppRoutes.connectingDevice);

    switch (state.dialogState) {
      case DialogState.none:
        break;
      case DialogState.requireBluetoothPermission:
      case DialogState.bluetoothNotAvailable:
        _showBluetoothPermissionDialog();
      case DialogState.requireLocationPermission:
      case DialogState.locationNotAvailable:
        _showLocationPermissionDialog();
      case DialogState.pairingDevice:
        _showConnectingDevice(state.connectingDevice);
      case DialogState.pairingFailed:
        _showConnectFailed();
    }
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            height: 250,
            width: 250,
            AppImages.bluetoothScanning,
            frameRate: FrameRate.max,
            controller: _btScanController,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              AppStrings.makeSureDeviceIsTurnedOn,
              style: AppTextStyles.regular(color: AppColors.blackSecondary),
              textAlign: TextAlign.center,
            ),
          ),
          _buildFoundDevices(),
          _buildButtons(),
        ],
      ),
    );
  }

  void _toggleScan() {
    final isStopScan = _bloc.state.screenState == ScreenState.stopScanning;
    if (isStopScan) {
      _btScanController.repeat();
      _bloc.handleScreenState(ScreenState.scanning);
    } else {
      _btScanController.stop();
      _bloc.handleScreenState(ScreenState.stopScanning);
    }
  }

  Widget _buildFoundDevices() {
    return BlocSelector<ConnectDeviceScreenBloc, ConnectDeviceScreenState, List<FoundDevice>>(
      selector: (state) => state.foundDevices,
      builder: (context, foundDevices) {
        if (foundDevices.isEmpty) {
          return Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.semanticYellow3, width: 2),
                  color: Colors.white),
            ),
          );
        }

        return Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.semanticYellow3, width: 2),
            ),
            child: ListView.builder(
              itemCount: foundDevices.length,
              itemBuilder: (context, index) {
                return _buildFoundCardItem(foundDevices[index]);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildFoundCardItem(FoundDevice device) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ConnectDeviceScreenFoundCardSelector(
        deviceAddress: device.address,
        builder: (foundCardType) => FoundDeviceCard(
          deviceName: device.name ?? AppStrings.unknownDevice,
          deviceAddress: device.address,
          type: foundCardType,
          onPressConnect: () => _bloc.connectDevice(device),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: OutlinedButtonApp(
              label: AppStrings.back,
              onPressed: () => AppNavigation.pop(context),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: BlocSelector<ConnectDeviceScreenBloc, ConnectDeviceScreenState, ScreenState>(
              selector: (state) => state.screenState,
              builder: (context, screenState) {
                return FilledButtonApp(
                  label: screenState == ScreenState.stopScanning
                      ? AppStrings.scan
                      : AppStrings.stopScan,
                  onPressed: _toggleScan,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

/*
*** DIALOG
*/

  void _showConnectingDevice(FoundDevice? device) {
    if (device == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return ConnectingDeviceDialog(deviceName: device.name ?? device.address);
      },
    );
  }

  void _showConnectFailed() {
    AppNavigation.popUntil(context, AppRoutes.connectingDevice);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomDialog(
          imagePath: AppImages.icError,
          isSVG: false,
          imageHeight: SizeApp.s52,
          title: AppStrings.failedToConnect,
          message: AppStrings.makeSureDeviceIsTurnedOn,
          positiveButtonText: AppStrings.ok,
          onPressPositiveButton: () {
            AppNavigation.pop(context);
          },
        );
      },
    );
  }

  void _showBluetoothPermissionDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return CustomDialog(
            isErrorDialog: false,
            isTitleCenter: true,
            title: AppStrings.flexoWouldLikeToAccessBluetooth,
            message: AppStrings.toConnectToDeviceWeNeed,
            positiveButtonText: AppStrings.goToSettings,
            onPressPositiveButton: () {
              AppNavigation.pop(context);
              AppSettings.openAppSettings();
            },
            negativeButtonText: AppStrings.cancel,
            onPressNegativeButton: () async {
              AppNavigation.popUntil(context, AppRoutes.home);
            },
          );
        });
  }

  void _showLocationPermissionDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return CustomDialog(
            isErrorDialog: false,
            isTitleCenter: true,
            title: AppStrings.flexoWouldLikeToAccessLocation,
            message: AppStrings.toConnectToDeviceWeNeedLocation,
            positiveButtonText: AppStrings.goToSettings,
            onPressPositiveButton: () {
              AppNavigation.pop(context);
              AppSettings.openAppSettings();
            },
            negativeButtonText: AppStrings.cancel,
            onPressNegativeButton: () async {
              AppNavigation.pop(context);
            },
          );
        });
  }
}
