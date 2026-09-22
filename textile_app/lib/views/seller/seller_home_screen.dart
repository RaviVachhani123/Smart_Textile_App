import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/seller_home_controller.dart';
import 'tabs/seller_dashboard_tab.dart';
import 'tabs/seller_products_tab.dart';
import 'tabs/seller_orders_tab.dart';
import 'tabs/seller_messages_tab.dart';
import 'tabs/seller_profile_tab.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerHomeController());

    final List<Widget> tabs = [
      const SellerDashboardTab(),
      const SellerProductsTab(),
      const SellerOrdersTab(),
      const SellerMessagesTab(),
      const SellerProfileTab(),
    ];

    return Scaffold(
      body: Obx(() => tabs[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changeTab,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Dashboard'),
            NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2), label: 'Products'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Orders'),
            NavigationDestination(icon: Icon(Icons.message_outlined), selectedIcon: Icon(Icons.message), label: 'Messages'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
