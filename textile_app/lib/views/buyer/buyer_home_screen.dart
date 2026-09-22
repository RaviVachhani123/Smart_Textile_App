import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/buyer_home_controller.dart';
import 'tabs/home_tab.dart';
import 'tabs/categories_tab.dart';
import '../../widgets/placeholder_screen.dart';
import '../../app/routes/app_routes.dart';

class BuyerHomeScreen extends StatelessWidget {
  const BuyerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BuyerHomeController());

    final List<Widget> tabs = [
      const HomeTab(),
      const CategoriesTab(),
      const PlaceholderScreen(title: 'Wishlist'),
      const PlaceholderScreen(title: 'Orders'),
      const PlaceholderScreen(title: 'Profile'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Textile Market'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => Get.toNamed(AppRoutes.wishlist),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Get.toNamed(AppRoutes.cart),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Buyer Dashboard', style: TextStyle(color: Colors.white, fontSize: 24)),
                  SizedBox(height: 8),
                  Text('Manage your B2B sourcing', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.request_quote_outlined),
              title: const Text('My Quotations'),
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.quotationList);
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2_outlined),
              title: const Text('My Sample Requests'),
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.sampleList);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Get.offAllNamed(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
      body: Obx(() => tabs[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changeTab,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.category_outlined), selectedIcon: Icon(Icons.category), label: 'Categories'),
            NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Orders'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
