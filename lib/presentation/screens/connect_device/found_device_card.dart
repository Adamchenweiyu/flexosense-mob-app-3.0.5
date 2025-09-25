// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flex_sense/presentation/widgets/commons/button/filled_button.dart';
import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/images/app_images.dart';
import 'package:flex_sense/application/resource/strings/app_strings.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';

enum FoundDeviceCardType {
  found,
  connecting,
  connected,
}

class FoundDeviceCard extends StatelessWidget {
  final String? deviceName;
  final String? deviceAddress;
  final VoidCallback? onPressConnect;
  final VoidCallback? onPressDisconnect;
  final FoundDeviceCardType type;

  const FoundDeviceCard({
    Key? key,
    this.deviceName,
    this.deviceAddress,
    this.onPressConnect,
    this.onPressDisconnect,
    this.type = FoundDeviceCardType.found,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey1, width: 2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDeviceInfo(),
          _buildCardStatus(),
        ],
      ),
    );
  }

  Widget _buildDeviceInfo() {
    return Flexible(
      child: Row(
        children: [
          _buildIcon(),
          _buildDeviceName(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Image.asset(
            AppImages.feetSensor,
            height: 30,
            width: 30,
            color: AppColors.semanticBlue,
          ),
          if (type == FoundDeviceCardType.connected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.semanticGreen,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDeviceName() {
    return Expanded(
      child: Text(
        deviceName ?? deviceAddress ?? AppStrings.unknownDevice,
        style: AppTextStyles.regular(color: AppColors.blackSecondary),
      ),
    );
  }

  Widget _buildCardStatus() {
    switch (type) {
      case FoundDeviceCardType.found:
        return FilledButtonApp(
          label: AppStrings.connect,
          color: AppColors.semanticOrange,
          paddingButton: const EdgeInsets.all(8),
          onPressed: onPressConnect,
        );

      case FoundDeviceCardType.connecting:
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.semanticOrange),
        );

      case FoundDeviceCardType.connected:
        return GestureDetector(
          onTap: onPressDisconnect,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AppImages.disconnectBluetooth,
              height: 30,
              width: 30,
            ),
          ),
        );
    }
  }
}
