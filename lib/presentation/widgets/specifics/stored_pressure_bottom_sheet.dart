// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flex_sense/application/util/pressure_utils.dart';
import 'package:flutter/material.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/fonts/app_font.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/data/repository/pressure_repo/pressure_repo.dart';
import 'package:flex_sense/presentation/navigation/app_navigation.dart';
import 'package:flex_sense/presentation/widgets/commons/app_bar/custom_app_bar.dart';
import 'package:flex_sense/presentation/widgets/commons/button/filled_button.dart';



class StoredPressureBottomSheet extends StatefulWidget {
  final String? title;
  final List<PressureEntityData> data;

  const StoredPressureBottomSheet({
    Key? key,
    this.title,
    required this.data,
  }) : super(key: key);

  @override
  State<StoredPressureBottomSheet> createState() => _StoredDataBottomSheetState();
}

class _StoredDataBottomSheetState extends State<StoredPressureBottomSheet> {
  List<PressureWithIndex> _data = [];

  final headers = ['Time', 'Index', 'Voltage'];
  var _isDeleting = false;
  var _isExportingAll = false;

  @override
  void initState() {
    _data = PressureUtils.convertEntityToPressureWithIndex(widget.data);

    super.initState();
  }



  Future<void> _exportDataToExcel(List<PressureEntityData> data) async {
    List<List<String>> listOfLists = [];

    final pressureWithIndexes = PressureUtils.convertEntityToPressureWithIndex(data);

    for (var i = 0; i < pressureWithIndexes.length; i++) {
      final element = pressureWithIndexes[i];
      final list = [
        element.time.toString(),
        element.index.toString(),
        element.voltage.toString(),
      ];
      listOfLists.add(list);
    }

    await exportCSV.myCSV(
      headers,
      listOfLists,
      setHeadersInFirstRow: true,
      fileName: "pressure",
    );
    print("exported");
  }

  void _exportAllData() async {
    setState(() {
      _isExportingAll = true;
    });
    dynamic data;
    data = await serviceLocator.get<PressureRepo>().get().get();

    await _exportDataToExcel(data);

    setState(() {
      _isExportingAll = false;
    });
  }

  void _deleteAllData() async {
    setState(() {
      _isDeleting = true;
    });

    await serviceLocator.get<PressureRepo>().deleteAll();

    setState(() {
      _isDeleting = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
          'Pressure Data',
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
                  final element = _data[index];
                  return ListTile(
                    title: Text(
                      'Index: ${element.index} - Voltages: ${element.voltage}',
                      style:
                          AppTextStyles.regular(color: AppColors.black1, fontSize: AppFontSize.s16),
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
