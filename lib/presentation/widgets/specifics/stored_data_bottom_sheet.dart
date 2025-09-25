// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/fonts/app_font.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/data/repository/imu_repo/imu_repo.dart';
import 'package:flex_sense/presentation/navigation/app_navigation.dart';
import 'package:flex_sense/presentation/widgets/commons/app_bar/custom_app_bar.dart';
import 'package:flex_sense/presentation/widgets/commons/button/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

class StoredDataBottomSheet extends StatefulWidget {
  final String? title;
  final List<ImuEntityData> data;

  const StoredDataBottomSheet({
    Key? key,
    this.title,
    required this.data,
  }) : super(key: key);

  @override
  State<StoredDataBottomSheet> createState() => _StoredDataBottomSheetState();
}

class _StoredDataBottomSheetState extends State<StoredDataBottomSheet> {
  final headers = [
    'Time',
    'AccX',
    'AccY',
    'AccZ',
    'GyrosX',
    'GyrosY',
    'GyrosZ',
  ];
  var _isDeleting = false;
  var _isExportingAll = false;

  Future<void> _exportDataToExcel(List<ImuEntityData> data) async {
    List<List<String>> listOfLists = [];
    for (var i = 0; i < data.length; i++) {
      final element = data[i];

      final list = [
        element.time.toString(),
        element.accX.toString(),
        element.accY.toString(),
        element.accZ.toString(),
        element.gyrosX.toString(),
        element.gyrosY.toString(),
        element.gyrosZ.toString(),
      ];

      listOfLists.add(list);
    }

    await exportCSV.myCSV(
      headers,
      listOfLists,
      setHeadersInFirstRow: true,
      fileName: "imu",
    );
    print("exported");
  }

  void _exportAllData() async {
    setState(() {
      _isExportingAll = true;
    });
    final data = await serviceLocator.get<ImuRepo>().get().get();

    await _exportDataToExcel(data);

    setState(() {
      _isExportingAll = false;
    });
  }

  void _deleteAllData() async {
    setState(() {
      _isDeleting = true;
    });
    await serviceLocator.get<ImuRepo>().deleteAll();

    setState(() {
      _isDeleting = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deleted all data'),
      ),
    );
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
        actionButtons: [
          IconButton(
            icon: Icon(Icons.save_alt, color: AppColors.black1),
            onPressed: () => _exportDataToExcel(widget.data),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FilledButtonApp(
                    label: "Export all data",
                    isLoading: _isExportingAll,
                    onPressed: _exportAllData,
                  ),
                ),
                Expanded(
                  child: FilledButtonApp(
                    isLoading: _isDeleting,
                    label: "Delete all data",
                    color: AppColors.redBase,
                    onPressed: _deleteAllData,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '${widget.data.length} latest samples',
                style: AppTextStyles.regular(color: AppColors.black1, fontSize: AppFontSize.s16),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  final imu = widget.data[index];
                  return ListTile(
                    title: Text(
                      '''Time: ${imu.time}\nAccX: ${imu.accX}, AccY: ${imu.accY}, AccZ: ${imu.accZ},\nGyrosX: ${imu.gyrosX}, GyrosY: ${imu.gyrosY}, GyrosZ: ${imu.gyrosZ}''',
                      style: AppTextStyles.regular(
                        color: AppColors.black1,
                        fontSize: AppFontSize.s16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    shape: Border.all(color: AppColors.black1),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
