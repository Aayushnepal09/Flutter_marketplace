import 'dart:io';
import 'package:KinBech/app/constants.dart';
import 'package:KinBech/data_source/remote_data_source/response/login_response.dart';
import 'package:KinBech/helper/http_service.dart';
import 'package:KinBech/model/user.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class UserRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> addUser(File? file, User user) async {
    try {
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType("image", mimeType!.split('/')[1]),
        );
      }
      FormData formData = FormData.fromMap({
        'fname': user.fname,
        'lname': user.lname,
        'email': user.email,
        'username': user.username,
        'password': user.password,
        'image': image,
      });
      Response response = await _httpServices.post(
        Constant.userURL,
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

  Future<bool> loginUser(username, password) async {
    try {
      Response response = await _httpServices.post(
        Constant.userLoginURL,
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Constant.token = "Bearer ${loginResponse.token}";
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
