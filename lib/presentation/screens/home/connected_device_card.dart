import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/images/app_images.dart';
import 'package:flex_sense/application/resource/strings/app_strings.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flutter/material.dart';

enum ConnectedCardType {
  notConnected,
  connected,
}

class ConnectedDeviceCard extends StatelessWidget {
  final String? deviceName;
  final String? deviceAddress;
  final String? hwVersion;
  final String? fwVersion;
  final String? batteryLevel;
  final bool isCharging;
  final VoidCallback? onPressed;
  final ConnectedCardType type;

  const ConnectedDeviceCard({
    Key? key,
    this.deviceName,
    this.deviceAddress,
    this.hwVersion,
    this.fwVersion,
    this.batteryLevel,
    this.isCharging = false,
    this.onPressed,
    this.type = ConnectedCardType.connected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey1, width: 2),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconAndStatus(),
            _buildDeviceInfo(),
            _buildGoToBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconAndStatus() {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 6),
      child: Column(
        children: [
          _buildIcon(),
          _buildCardStatus(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Image.asset(
        AppImages.feetSensor,
        height: 30,
        width: 30,
        color: AppColors.semanticBlue,
      ),
    );
  }

  Widget _buildCardStatus() {
    switch (type) {
      case ConnectedCardType.notConnected:
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.neutral4,
            shape: BoxShape.circle,
          ),
        );
      case ConnectedCardType.connected:
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.semanticGreen,
            shape: BoxShape.circle,
          ),
        );
    }
  }

  Widget _buildDeviceInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            deviceName ?? AppStrings.unknownDevice,
            style: AppTextStyles.bold(color: AppColors.blackSecondary),
          ),
          Text(
            deviceAddress ?? AppStrings.unknownDevice,
            style: AppTextStyles.regular(color: AppColors.blackSecondary, fontSize: 12),
          ),
          Text(
            '${AppStrings.fwVersion}: ${fwVersion ?? '-'}',
            style: AppTextStyles.regular(color: AppColors.blackSecondary, fontSize: 12),
          ),
          Text(
            '${AppStrings.hwVersion}: ${hwVersion ?? '-'}',
            style: AppTextStyles.regular(color: AppColors.blackSecondary, fontSize: 12),
          ),
          Row(
            children: [
              Image.asset(
                isCharging ? AppImages.icBatteryCharging : AppImages.icBattery,
                height: 16,
                width: 16,
              ),
              Text(
                ' : ${batteryLevel ?? '-'}',
                style: AppTextStyles.regular(color: AppColors.blackSecondary, fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGoToBtn() {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      child: RotatedBox(
        quarterTurns: 2,
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColors.greyScale,
        ),
      ),
    );
  }
}
