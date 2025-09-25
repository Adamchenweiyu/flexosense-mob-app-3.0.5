import 'package:flex_sense/plugin/device_core/models/pressure.dart';
import 'package:flex_sense/presentation/navigation/app_navigation.dart';
import 'package:flex_sense/presentation/widgets/commons/app_bar/custom_app_bar.dart';
import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/fonts/app_font.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LivePressureBottomSheet extends StatefulWidget {
  final String? title;
  final List<double> data;

  const LivePressureBottomSheet({
    Key? key,
    this.title,
    required this.data,
  }) : super(key: key);

  @override
  State<LivePressureBottomSheet> createState() => _LivePressureBottomSheetState();
}

class _LivePressureBottomSheetState extends State<LivePressureBottomSheet> {
  final ScrollController _accScrollController = ScrollController();
  bool _accShouldAutoScroll = true;
  List<double> _data = [];

  @override
  void initState() {
    _accScrollController.addListener(_setupAccScrollListener);
    _data = widget.data.take(14).toList(); // Ensure only 14 values are used
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LivePressureBottomSheet oldWidget) {
    if (oldWidget.data != widget.data) {
      _data = widget.data.take(14).toList(); // Update only 14 values
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _accScrollController.dispose();
    super.dispose();
  }

  void _setupAccScrollListener() {
    if (_accScrollController.position.userScrollDirection == ScrollDirection.reverse) {
      _accShouldAutoScroll = false;
    } else if (_accScrollController.position.atEdge) {
      bool isBottom =
          _accScrollController.position.pixels == _accScrollController.position.maxScrollExtent;
      if (isBottom) {
        _accShouldAutoScroll = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidget: IconButton(
          icon: Icon(Icons.close, color: AppColors.black1),
          onPressed: () => AppNavigation.pop(context),
        ),
        titleWidget: Text(
          widget.title ?? 'Live Data',
          style: AppTextStyles.bold(color: AppColors.black1),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          controller: _accScrollController,
          itemCount: _data.length, // Ensure it does not exceed 14
          itemBuilder: (context, index) {
            final voltage = _data[index];
            return ListTile(
              title: Text(
                'Voltage ${index + 1}: ${voltage.toStringAsFixed(2)}',
                style: AppTextStyles.regular(color: AppColors.black1, fontSize: AppFontSize.s16),
              ),
            );
          },
        ),
      ),
    );
  }
}
