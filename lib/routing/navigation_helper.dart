import 'package:get/get.dart';

class NavigationHelper {
  navigateToRoutes({required String route, var args, required int caseType}) {
    switch (caseType) {
      case 1:
        ///-----push
        Get.toNamed(route, arguments: args);
      case 2:
        ///----replacement
        Get.offAllNamed(route, arguments: args);
      case 3:
        Get.offAndToNamed(route, arguments: args);
        case 4:
        Get.offNamed(route, arguments: args);
    }
  }

  back() {
    Get.back();
  }
}
