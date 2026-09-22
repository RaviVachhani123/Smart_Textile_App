import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/wishlist_controller.dart';
import '../../widgets/product_card.dart';
import '../../app/routes/app_routes.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        elevation: 0,
      ),
      body: Obx(() {
        if (wishlistController.wishlistItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_outline, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  'No products saved yet',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore products and tap the heart icon\nto save them here for later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to buyer home (which is the root or tab)
                    Get.until((route) => Get.currentRoute == AppRoutes.buyerHome);
                  },
                  child: const Text('Explore Products'),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemCount: wishlistController.wishlistItems.length,
          itemBuilder: (context, index) {
            final product = wishlistController.wishlistItems[index];
            return ProductCard(product: product);
          },
        );
      }),
    );
  }
}
