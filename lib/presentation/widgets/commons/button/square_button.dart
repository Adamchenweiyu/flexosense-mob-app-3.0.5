import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SquareButton extends StatelessWidget {
  final String icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;

  final VoidCallback? onPressed;
  const SquareButton(
      {required this.icon,
      this.backgroundColor,
      this.iconColor,
      this.borderColor,
      this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(
              color: borderColor ?? AppColors.blackSecondary3, width: 1),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            onPressed?.call();
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              icon,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                  iconColor ?? AppColors.blackSecondary3, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
