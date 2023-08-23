import 'dart:io';
import 'package:KinBech/app/constants.dart';
import 'package:KinBech/data_source/remote_data_source/response/product_response.dart';
import 'package:KinBech/helper/http_service.dart';
import 'package:KinBech/model/products.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ProductRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();
  Future<int> addProdct(File? file, Product product) async {
    try {
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );
      }
      FormData formData = FormData.fromMap({
        'name': product.name,
        'price': product.price,
        'description': product.description,
        'image': image,
      });
      Response response = await _httpServices.post(
        Constant.productURL,
        options: Options(headers: {
          "Authorization": Constant.token,
        }),
        data: formData,
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<List<Product>> getAllProduct() async {
    try {
      Response response = await _httpServices.get(
        Constant.productURL,
      );
      if (response.statusCode == 200) {
        ProductResponse productResponse =
            ProductResponse.fromJson(response.data);
        return productResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Product>?> getProductsByCategory(String categoryId) async {
    try {
      Response response = await _httpServices.get(
        Constant.searchProductByCategoryURL,
        queryParameters: {
          'categoryId': categoryId,
        },
      );
      if (response.statusCode == 201) {
        ProductResponse proResponse = ProductResponse.fromJson(response.data);
        return proResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
