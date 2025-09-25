import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/images/app_images.dart';
import 'package:flex_sense/application/resource/strings/app_strings.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConnectingDeviceDialog extends StatelessWidget {
  final String deviceName;
  const ConnectingDeviceDialog({
    Key? key,
    required this.deviceName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(
        top: 26,
        bottom: 40,
        left: 20,
        right: 20,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 100,
              minHeight: 120,
            ),
            child: Transform.scale(
              scale: 0.8,
              child: Lottie.asset(
                AppImages.appLoadingAmongUs,
                frameRate: FrameRate.max,
              ),
            ),
          ),
          Text(
            '${AppStrings.connecting} $deviceName',
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold(color: AppColors.blackSecondary5, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              AppStrings.yourDeviceIsBeingConnected,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular(color: AppColors.blackSecondary3, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
