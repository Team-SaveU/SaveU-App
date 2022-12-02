import 'package:save_u/db_helper/repository.dart';

class SubCategoryService {
  late Repository _repository;
  SubCategoryService() {
    _repository = Repository();
  }

  //모든 SubCategory 가져오기
  readAllSubCategories() async {
    return await _repository.readData('subCategory');
  }
}
