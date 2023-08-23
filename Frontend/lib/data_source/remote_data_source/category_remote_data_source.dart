import 'package:KinBech/app/constants.dart';
import 'package:KinBech/data_source/remote_data_source/response/category_response.dart';
import 'package:KinBech/helper/http_service.dart';
import 'package:KinBech/model/category.dart';
import 'package:dio/dio.dart';

class CategoryRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<List<Category>> getAllCategory() async {
    try {
      Response response = await _httpServices.get(
        Constant.categoryURL,
      );
      if (response.statusCode == 200) {
        CategoryResponse categoryResponse =
            CategoryResponse.fromJson(response.data);
        return categoryResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
