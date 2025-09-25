import 'dart:async';
import 'dart:io';

import 'package:flex_sense/data/repository/upload_repo/upload_repo.dart';
import 'package:flex_sense/domain/use_case/use_case.dart';

class UploadData extends UseCase<void, File> {
  final UploadRepo _uploadRepo;

  const UploadData(this._uploadRepo);

  @override
  Future<void> call(File params) async {
    await _uploadRepo.uploadFile(params);
  }
}
