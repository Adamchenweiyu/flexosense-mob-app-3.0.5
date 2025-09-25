// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flex_sense/presentation/navigation/app_navigation.dart';
import 'package:flex_sense/presentation/widgets/commons/app_bar/custom_app_bar.dart';
import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/fonts/app_font.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LiveDataBottomSheet extends StatefulWidget {
  final String? title;
  final List<dynamic> data;
  final bool isRollPitchYaw;

  const LiveDataBottomSheet({
    Key? key,
    this.title,
    required this.data,
    this.isRollPitchYaw = false,
  }) : super(key: key);

  @override
  State<LiveDataBottomSheet> createState() => _LiveDataBottomSheetState();
}

class _LiveDataBottomSheetState extends State<LiveDataBottomSheet> {
  // Scroll controller for the ListView
  final ScrollController _accScrollController = ScrollController();

  // Flag to determine if auto-scroll should happen
  bool _accShouldAutoScroll = true;
  List<dynamic> _data = [];

  @override
  void initState() {
    _accScrollController.addListener(_setupAccScrollListener);
    _data = widget.data;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LiveDataBottomSheet oldWidget) {
    if (oldWidget.data != widget.data) {
      _data = widget.data;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _accScrollController.dispose();
    super.dispose();
  }

  void _setupAccScrollListener() {
    // Check if the user has scrolled up
    if (_accScrollController.position.userScrollDirection == ScrollDirection.reverse) {
      // User scrolled up
      _accShouldAutoScroll = false;
    } else if (_accScrollController.position.atEdge) {
      // At the top or bottom
      bool isBottom =
          _accScrollController.position.pixels == _accScrollController.position.maxScrollExtent;
      if (isBottom) {
        // User is at the bottom of the list
        _accShouldAutoScroll = true;
      }
    }
  }

  double _calculateItemHeight() {
    // If all items have the same height, we can estimate it
    // For ListTile, the default height is approximately 56.0
    // Adjust this value if your item height is different
    return 56.0;
  }

  @override
  Widget build(BuildContext context) {
    if (_accShouldAutoScroll) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_accScrollController.hasClients) {
          // Calculate the scroll offset to scroll over the new items
          double itemHeight = _calculateItemHeight();
          double scrollOffset = itemHeight * 20;

          // Calculate the new scroll position
          double currentPosition = _accScrollController.position.pixels;
          double maxScrollExtent = _accScrollController.position.maxScrollExtent;

          // Ensure we don't scroll beyond the maximum extent
          double targetPosition = (currentPosition + scrollOffset).clamp(0.0, maxScrollExtent);

          // Adjust the duration based on the number of new items
          // Let's assume 50 milliseconds per item for visibility
          int durationPerItem = 50; // Adjust as needed
          int totalDuration =
              (durationPerItem * 20).clamp(300, 2000); // Clamp between 300ms and 2000ms

          _accScrollController.animateTo(
            targetPosition,
            duration: Duration(milliseconds: totalDuration),
            curve: Curves.linear,
          );
        }
      });
    }
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
          itemCount: _data.length,
          itemBuilder: (context, index) {
            final element = _data[index];
            return ListTile(
              title: Text(
                'X: ${widget.isRollPitchYaw ? element.roll : element.x}, Y: ${widget.isRollPitchYaw ? element.pitch : element.y}, Z: ${widget.isRollPitchYaw ? element.yaw : element.z}',
                style: AppTextStyles.regular(color: AppColors.black1, fontSize: AppFontSize.s16),
              ),
            );
          },
        ),
      ),
    );
  }
}
