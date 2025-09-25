import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/plugin/device_core/models/connected_device.dart';
import 'package:flex_sense/presentation/navigation/app_navigation.dart';
import 'package:flex_sense/presentation/navigation/app_routes.dart';
import 'package:flex_sense/presentation/screens/connect_device/found_device_card.dart';
import 'package:flex_sense/presentation/screens/home/bloc/home_screen_bloc.dart';
import 'package:flex_sense/presentation/screens/home/bloc/home_screen_bloc_selector.dart';
import 'package:flex_sense/presentation/screens/home/connected_device_card.dart';
import 'package:flex_sense/presentation/widgets/commons/app_bar/custom_app_bar.dart';
import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/images/app_images.dart';
import 'package:flex_sense/application/resource/strings/app_strings.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flex_sense/presentation/widgets/specifics/stored_data_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = serviceLocator.get<HomeScreenBloc>();

  @override
  void initState() {
    _bloc.initState();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: HomeScreenBlocSelector(
                  builder: (devices) {
                    if (devices.isEmpty) {
                      return _buildEmptyDevicesUI(context);
                    }

                    return _buildConnectedDevicesUI(devices);
                  },
                ),
              ),
              // _buildViewStoredAccel(),
              _buildAddDeviceBtn(),
            ],
          ),
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      titleWidget: Text(AppStrings.home),
    );
  }

  Widget _buildConnectedDevicesUI(List<ConnectedDevice> devices) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              return _buildConnectedCardItem(devices[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildConnectedCardItem(ConnectedDevice device) {
    return ConnectedDeviceCard(
      deviceName: device.name,
      deviceAddress: device.address,
      onPressed: () => AppNavigation.routeTo(context, AppRoutes.deviceDetail, args: device),
    );
  }

  Widget _buildEmptyDevicesUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            AppStrings.noDevice,
            style: AppTextStyles.bold(
              color: AppColors.black1,
              fontSize: 20,
            ),
          ),
        ),
        Image.asset(
          AppImages.emptyDevice,
          width: MediaQuery.of(context).size.width * 0.65,
        ),
      ],
    );
  }

  // Widget _buildViewStoredAccel() {
  //   return FilledButton(
  //     style: FilledButton.styleFrom(backgroundColor: AppColors.semanticGreen),
  //     onPressed: _onPressViewStoredAccel,
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(AppStrings.viewStoredAccel),
  //         const SizedBox(width: 8),
  //         const Icon(Icons.view_agenda),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildAddDeviceBtn() {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: AppColors.primaryBase),
      onPressed: _onPressAddDevice,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppStrings.addDevice),
          const SizedBox(width: 8),
          const Icon(Icons.add),
        ],
      ),
    );
  }

  void _onPressAddDevice() {
    AppNavigation.routeTo(context, AppRoutes.connectingDevice);
  }

  // void _onPressViewStoredAccel() async {
  //   final data = await _bloc.onPressViewStoredAccelData();

  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20),
  //         topRight: Radius.circular(20),
  //       ),
  //     ),
  //     builder: (_) => FractionallySizedBox(
  //       heightFactor: 0.92,
  //       child: StoredDataBottomSheet(
  //         title: AppStrings.viewStoredData,
  //         data: data,
  //       ),
  //     ),
  //   );
  // }
}
