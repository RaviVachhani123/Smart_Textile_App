import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';
import 'controllers/cart_controller.dart';
import 'controllers/wishlist_controller.dart';
import 'controllers/quotation_controller.dart';
import 'controllers/sample_controller.dart';

void main() {
  runApp(const SmartTextileMarketApp());
}

class SmartTextileMarketApp extends StatelessWidget {
  const SmartTextileMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Textile Market',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      initialBinding: BindingsBuilder(() {
        Get.put(CartController(), permanent: true);
        Get.put(WishlistController(), permanent: true);
        Get.put(QuotationController(), permanent: true);
        Get.put(SampleController(), permanent: true);
      }),
      getPages: AppPages.pages,
    );
  }
}
