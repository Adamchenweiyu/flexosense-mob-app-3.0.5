import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class OutlinedButtonApp extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool hasBorder;
  final double? borderWidth;
  final Color? colorText;
  final Color? borderColor;
  final Color? bgColor;
  final double? fontSizeText;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? paddingButton;
  final bool isLoading;
  const OutlinedButtonApp({
    Key? key,
    this.onPressed,
    required this.label,
    this.hasBorder = true,
    this.colorText,
    this.borderWidth,
    this.borderColor,
    this.bgColor,
    this.fontSizeText,
    this.labelStyle,
    this.paddingButton,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        side: !hasBorder
            ? const BorderSide(color: Colors.transparent)
            : BorderSide(
                width: borderWidth ?? (isLoading ? 1 : 2),
                color: borderColor ??
                    (isLoading
                        ? AppColors.coalLighter
                        : AppColors.primaryLight),
              ),
        backgroundColor: bgColor ?? AppColors.white,
        padding: paddingButton,
      ),
      child: isLoading
          ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primaryLight,
              ),
            )
          : Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: labelStyle ??
                  AppTextStyles.bold(
                    color: colorText ?? AppColors.primaryBase,
                    fontSize: fontSizeText ?? 16,
                  ),
            ),
    );
  }
}
