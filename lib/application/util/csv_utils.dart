import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flex_sense/application/util/date_time_utils.dart';

import 'package:flex_sense/data/data_source/local/drift/app_database.dart';
import 'package:path_provider/path_provider.dart';

class CsvUtils {
  static Future<File> convertImuToCsv(List<ImuEntityData> imuList) async {
    final headers = [
      'DeviceAddress',
      'Time',
      'MsgIndex',
      'AccX',
      'AccY',
      'AccZ',
      'GyrosX',
      'GyrosY',
      'GyrosZ',
    ];

    List<List<dynamic>> listOfLists = [];
    listOfLists.add(headers);

    for (var i = 0; i < imuList.length; i++) {
      final element = imuList[i];

      final list = [
        element.deviceAddress,
        element.time.toString(),
        element.msgIndex.toString(),
        element.accX.toString(),
        element.accY.toString(),
        element.accZ.toString(),
        element.gyrosX.toString(),
        element.gyrosY.toString(),
        element.gyrosZ.toString(),
      ];

      listOfLists.add(list);
    }

    final csvString = const ListToCsvConverter().convert(listOfLists);

    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final lastDataTime = imuList.last.time;

    final File csvFile = File('$tempPath/imu_${lastDataTime.toFileFormattedDate}.csv');

    await csvFile.writeAsString(csvString);

    return csvFile;
  }

  static Future<File> convertMagneticToCsv(List<MagneticEntityData> magneticList) async {
    final headers = [
      'DeviceAddress',
      'Time',
      'MsgIndex',
      'MagneticX',
      'MagneticY',
      'MagneticZ',
    ];

    List<List<dynamic>> listOfLists = [];
    listOfLists.add(headers);

    for (var i = 0; i < magneticList.length; i++) {
      final element = magneticList[i];

      final list = [
        element.deviceAddress,
        element.time.toString(),
        element.msgIndex.toString(),
        element.x.toString(),
        element.y.toString(),
        element.z.toString(),
      ];

      listOfLists.add(list);
    }

    final csvString = const ListToCsvConverter().convert(listOfLists);

    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final lastDataTime = magneticList.last.time;

    final File csvFile = File('$tempPath/magnetic_${lastDataTime.toFileFormattedDate}.csv');

    await csvFile.writeAsString(csvString);

    return csvFile;
  }

  static Future<File> convertPressureToCsv(List<PressureEntityData> pressureList) async {
    final headers = <String>[
      'DeviceAddress',
      'Time',
      for (int i = 0; i < 14; i++) 'Vol Id$i',
    ];

    List<List<String>> listOfLists = [];
    listOfLists.add(headers);

    for (var i = 0; i < pressureList.length; i++) {
      List<String> row = [];
      final pressureEntity = pressureList[i];
      row.add(pressureEntity.deviceAddress);
      row.add(pressureEntity.time.toString());
      List<String> listOfVoltages = pressureEntity.voltages.split(';');
      row.addAll(listOfVoltages);
      listOfLists.add(row);
    }

    final csvString = const ListToCsvConverter().convert(listOfLists);

    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;

    final lastDataTime = pressureList.isNotEmpty ? pressureList.last.time : DateTime.now();
    final File csvFile = File('$tempPath/pressure_${lastDataTime.toFileFormattedDate}.csv');

    await csvFile.writeAsString(csvString);

    return csvFile;
  }
}
