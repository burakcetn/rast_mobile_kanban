import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rast_mobile_kanban/data/models/user_login_model.dart';
import 'package:rast_mobile_kanban/data/repos/user_repo.dart';
import 'package:rast_mobile_kanban/routes/app_pages.dart';

class LoginPageBloc {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginButtonFuction() async {
    var loginUser = UserLoginModel(
        email: emailController.text, password: passwordController.text);
    bool isLogged = await UserRepository().loginUser(loginUser);
    if (isLogged == true) {
      Get.offAllNamed(Routes.HOME);
    }
  }
}
