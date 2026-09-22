import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../controllers/seller_products_controller.dart';
import '../../../app/routes/app_routes.dart';

class SellerProductsTab extends StatelessWidget {
  const SellerProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerProductsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ),
      body: Obx(() {
        if (controller.myProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[300]),
                const SizedBox(height: 16),
                const Text('No products in your catalog'),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => Get.toNamed(AppRoutes.sellerAddProduct),
                  icon: const Icon(Icons.add),
                  label: const Text('Add First Product'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.myProducts.length,
          itemBuilder: (context, index) {
            final product = controller.myProducts[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: const Icon(Icons.inventory_2_outlined, size: 40, color: Colors.grey),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 4),
                          Text('Category: ${product.category}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('₹${product.price}/${product.unit}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                              Text('Stock: ${product.inStock ? "Yes" : "No"}', style: TextStyle(color: product.inStock ? Colors.green : Colors.red, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit')),
                      const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                    ],
                    onSelected: (val) {
                      if (val == 'edit') {
                        Get.toNamed(AppRoutes.sellerAddProduct, arguments: product);
                      } else if (val == 'delete') {
                        _showDeleteConfirm(context, controller, product.id);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: Obx(() => controller.myProducts.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () => Get.toNamed(AppRoutes.sellerAddProduct),
              icon: const Icon(Icons.add),
              label: const Text('Add Product'),
            )
          : const SizedBox.shrink()),
    );
  }

  void _showDeleteConfirm(BuildContext context, SellerProductsController controller, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              controller.deleteProduct(id);
              Get.back();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
