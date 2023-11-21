import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rast_mobile_kanban/ui/blocs/login_page_bloc.dart';
import 'package:rast_mobile_kanban/ui/views/login_page/login_page.dart';

// ignore: must_be_immutable
class LoginForm extends StatelessWidget {
  LoginPageBloc bloc;
  LoginForm({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "LogIn",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          height: 140.h,
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            decoration: inputDecorationConstant("email", Icons.email),
            controller: bloc.emailController,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          height: 140.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white30,
          ),
          child: TextField(
            decoration: inputDecorationConstant("password", Icons.key),
            controller: bloc.passwordController,
          ),
        )
      ],
    );
  }
}
