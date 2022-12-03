import '../db_helper/repository.dart';

class SafeInfoService {
  late Repository _repository;
  SafeInfoService() {
    _repository = Repository();
  }

  readSafeInfosBySubCategoryId(int subCategoryId) async {
    return await _repository.readDataByColumn(
        'safeInfo', 'subCategoryId', subCategoryId);
  }
}
