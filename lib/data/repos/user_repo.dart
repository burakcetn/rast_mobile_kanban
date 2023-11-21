import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rast_mobile_kanban/data/locals/mysharedpref.dart';
import 'package:rast_mobile_kanban/data/models/error_model.dart';
import 'package:rast_mobile_kanban/data/models/login_response_model.dart';

import 'package:rast_mobile_kanban/data/models/user_login_model.dart';
import 'package:rast_mobile_kanban/ui/views/utils/constants.dart';
import 'package:rast_mobile_kanban/ui/views/utils/custom_snackbar.dart';

class UserRepository {
  final dio = Dio();

  Future<bool> loginUser(UserLoginModel userLoginModel) async {
    Response response;
    try {
      response = await dio.post("${AppConstants.baseUrl}api/login",
          data: userLoginModel.toJson(),
          options: Options(headers: {
            "x-lang": "tr",
            "Accept": "application/json",
            "Content-type": "application/json"
          }));
      if (response.statusCode == 200) {
        LoginResponseModel token = LoginResponseModel.fromJson(response.data);
        MySharedPref.setToken(token.token);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      debugPrint(e.response.toString());
      ErrorModel error = ErrorModel.fromJson(e.response?.data);
      CustomSnackBar.showCustomErrorSnackBar(
          title: "Hata", message: error.error);
      return false;
    }
  }
}
