import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rast_mobile_kanban/ui/blocs/login_page_bloc.dart';
import 'package:rast_mobile_kanban/ui/views/login_page/custom_background_painter.dart';
import 'package:rast_mobile_kanban/ui/views/login_page/login_form.dart';

import 'package:rast_mobile_kanban/ui/views/utils/constants.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginPageBloc bloc = LoginPageBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              CustomPaint(
                painter: CustomBackgroundPainter(),
                size: Size(1080.w, 1200.h),
              ),
              Positioned(
                top: 390.h,
                left: 200.w,
                child: Material(
                  type: MaterialType.transparency,
                  child: Hero(
                    tag: "logoHero",
                    child: SizedBox(
                      height: 900.h,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/logo.png",
                              height: 200.h,
                            ),
                          ),
                          Image.asset(
                            "assets/images/logo_script.png",
                            width: 700.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2400.h,
                width: 1080.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 400.h,
                    ),
                    LoginForm(bloc: bloc),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: SizedBox(
                          height: 150.h,
                          width: 340.w,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            onPressed: () => bloc.loginButtonFuction(),
                            child: const Text("Login"),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

InputDecoration inputDecorationConstant(
  String labelText,
  IconData iconData, {
  String? prefix,
  String? helperText,
}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    helperText: helperText,
    labelText: labelText,
    prefixStyle: const TextStyle(color: Colors.white, fontSize: 14),
    suffixStyle: const TextStyle(color: Colors.white, fontSize: 14),
    hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
    labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
    fillColor: Colors.transparent,
    filled: true,
    // prefixText: prefix,
    prefixIcon: Icon(
      iconData,
      size: 20,
      color: Colors.white,
    ),
    prefixIconConstraints: const BoxConstraints(minWidth: 60),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      // borderSide: BorderSide(color: Colors.grey),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      // borderSide: BorderSide(color: Colors.grey),
    ),
  );
}
