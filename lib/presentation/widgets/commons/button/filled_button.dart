import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class FilledButtonApp extends StatelessWidget {
  final String label;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final Color? textColorDisable;
  final VoidCallback? onPressed;
  final bool isEnable;
  final bool hasShadow;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? paddingButton;

  const FilledButtonApp({
    super.key,
    required this.label,
    this.isLoading = false,
    this.color,
    this.textColor,
    this.textColorDisable,
    this.onPressed,
    this.isEnable = true,
    this.hasShadow = true,
    this.labelStyle,
    this.paddingButton,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnable ? onPressed : null,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: AppColors.neutral4,
        backgroundColor: color ?? AppColors.blackSecondary4,
        padding: paddingButton,
        shadowColor: hasShadow ? AppColors.fogBackground : Colors.transparent,
      ),
      child: isLoading
          ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2),
              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white),
            )
          : Text(
              label,
              style: labelStyle ??
                  AppTextStyles.semiBold(fontSize: 16, color: textColor ?? AppColors.white),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
    );
  }
}
