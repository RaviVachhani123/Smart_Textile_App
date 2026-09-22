import 'package:get/get.dart';
import '../app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    // For now, always navigate to onboarding. 
    // In future phases, this could check if user is already logged in.
    Get.offNamed(AppRoutes.onboarding);
  }
}
