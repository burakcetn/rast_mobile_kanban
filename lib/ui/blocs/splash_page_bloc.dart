import 'package:get/get.dart';
import 'package:rast_mobile_kanban/routes/app_pages.dart';

class SplashPageBloc {
  //change page after 5 seconds and clear the all tree
  Future<void> splashPageCounterToNextPage() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.offAllNamed(Routes.LOGIN);
  }
}
