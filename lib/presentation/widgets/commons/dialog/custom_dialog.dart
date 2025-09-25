import 'package:flex_sense/presentation/widgets/commons/button/filled_button.dart';
import 'package:flex_sense/presentation/widgets/commons/button/outline_button.dart';
import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/fonts/app_font.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flex_sense/application/resource/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDialog extends StatefulWidget {
  final bool isErrorDialog;
  final String? imagePath;
  final String title;
  final bool? isMessageCenter;
  final bool? isTitleCenter;
  final String? message;
  final bool? isSVG;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final String? neutralButtonText;
  final VoidCallback? onPressPositiveButton;
  final VoidCallback? onPressNegativeButton;
  final VoidCallback? onPressNeutraltiveButton;
  final double imageHeight;
  final bool? showLoadingAfterPressPositive;
  final Widget? customMessage;
  final bool hasBorderNeutralButton;
  final Color? textColorNeutralButton;

  const CustomDialog({
    Key? key,
    this.isErrorDialog = false,
    this.imagePath,
    required this.title,
    this.isTitleCenter = false,
    this.isMessageCenter = true,
    this.message,
    this.isSVG = true,
    this.positiveButtonText,
    this.negativeButtonText,
    this.neutralButtonText,
    this.onPressPositiveButton,
    this.onPressNegativeButton,
    this.onPressNeutraltiveButton,
    this.imageHeight = SizeApp.s120,
    this.showLoadingAfterPressPositive = false,
    this.customMessage,
    this.hasBorderNeutralButton = false,
    this.textColorNeutralButton,
  }) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: PaddingApp.p16,
        vertical: PaddingApp.p24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeApp.s12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(PaddingApp.p16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _renderImage(),
            _renderTitle(),
            _renderContentText(),
            _renderPositiveButton(),
            _renderNeutralButton(),
            _renderNegativeButton(),
          ],
        ),
      ),
    );
  }

  Widget _renderNegativeButton() {
    final padding =
        (widget.positiveButtonText == null && widget.neutralButtonText == null)
            ? MarginApp.m20
            : MarginApp.m8;
    return widget.negativeButtonText != null
        ? Container(
            margin: EdgeInsets.only(top: padding),
            width: double.infinity,
            child: OutlinedButtonApp(
              label: widget.negativeButtonText!,
              hasBorder: false,
              colorText: AppColors.blackSecondary4,
              onPressed: widget.onPressNegativeButton,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _renderNeutralButton() {
    final padding =
        widget.positiveButtonText == null ? MarginApp.m16 : MarginApp.m8;
    return widget.neutralButtonText != null
        ? Container(
            margin: EdgeInsets.only(top: padding),
            width: double.infinity,
            child: OutlinedButtonApp(
              label: widget.neutralButtonText!,
              hasBorder: widget.hasBorderNeutralButton,
              colorText: widget.textColorNeutralButton ??
                  (widget.isErrorDialog ? AppColors.coalDarkest : null),
              borderColor: widget.isErrorDialog ? AppColors.redBase : null,
              onPressed: widget.onPressNeutraltiveButton,
              borderWidth: widget.hasBorderNeutralButton ? 2 : null,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _renderPositiveButton() {
    return widget.positiveButtonText != null
        ? Container(
            margin: const EdgeInsets.only(top: MarginApp.m16),
            width: double.infinity,
            height: SizeApp.s48,
            child: FilledButtonApp(
              isLoading: _isLoading,
              label: widget.positiveButtonText ?? '',
              color: widget.isErrorDialog ? AppColors.semanticRed3 : null,
              onPressed: () {
                if (widget.showLoadingAfterPressPositive == true) {
                  setState(() {
                    _isLoading = true;
                  });
                }
                widget.onPressPositiveButton?.call();
              },
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _renderContentText() {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(top: MarginApp.m12),
        child: widget.customMessage != null
            ? widget.customMessage!
            : widget.message != null
                ? Text(
                    widget.message!,
                    style: AppTextStyles.regular(
                      lineHeight: SizeApp.s26,
                      color: AppColors.blackSecondary3,
                      fontSize: AppFontSize.s15,
                    ),
                    textAlign: widget.isMessageCenter == true
                        ? TextAlign.center
                        : TextAlign.left,
                  )
                : const SizedBox.shrink(),
      ),
    );
  }

  Container _renderTitle() {
    return Container(
      margin: const EdgeInsets.only(top: MarginApp.m20),
      child: Text(
        widget.title,
        style: AppTextStyles.semiBold(
            lineHeight: SizeApp.s28,
            color: AppColors.blackSecondary5,
            fontSize: AppFontSize.s18),
        textAlign:
            widget.isTitleCenter == true ? TextAlign.center : TextAlign.left,
      ),
    );
  }

  Widget _renderImage() {
    return Padding(
      padding: const EdgeInsets.only(top: MarginApp.m14),
      child: widget.imagePath != null
          ? widget.isSVG == true
              ? SvgPicture.asset(widget.imagePath!, height: widget.imageHeight)
              : Container(
                  height: widget.imageHeight,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.imagePath!),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
          : const SizedBox.shrink(),
    );
  }
}
