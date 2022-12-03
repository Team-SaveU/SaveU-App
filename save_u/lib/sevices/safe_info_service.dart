import 'package:save_u/models/safe_info.dart';

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

  updateSafeInfoScrap(int id, int scrap) async {
    return await _repository.updateColumn('safeInfo', id, 'scrap', scrap);
  }
}
