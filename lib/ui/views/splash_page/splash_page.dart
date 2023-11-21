import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rast_mobile_kanban/ui/blocs/splash_page_bloc.dart';
import 'package:rast_mobile_kanban/ui/views/utils/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashPageBloc _bloc = SplashPageBloc();

  @override
  void initState() {
    super.initState();
    _bloc.splashPageCounterToNextPage();
  }

// main view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          upperShapesBuilder(),
          logoBuilder(),
          lowerShapesbuilder(),
        ],
      ),
    );
  }

  Column lowerShapesbuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 554.h,
          width: 270.w,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            color: AppConstants.primaryColor,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 270.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                  ),
                  color: AppConstants.primaryColor,
                ),
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Container(
              height: 270.w,
              width: 270.w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                ),
                color: AppConstants.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Material logoBuilder() {
    return Material(
      type: MaterialType.transparency,
      child: Hero(
        tag: "logoHero",
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/logo.png",
                height: 135.h,
              ),
            ),
            Image.asset(
              "assets/images/logo_script.png",
              width: 600.w,
            ),
          ],
        ),
      ),
    );
  }

  Column upperShapesBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 270.w,
              width: 270.w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
                color: AppConstants.primaryColor,
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Container(
                height: 270.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                  ),
                  color: AppConstants.primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          height: 554.h,
          width: 270.w,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: AppConstants.primaryColor,
          ),
        ),
      ],
    );
  }
}
