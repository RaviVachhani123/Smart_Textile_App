import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/seller_products_controller.dart';

class SellerInventoryScreen extends StatelessWidget {
  const SellerInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerProductsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management'),
      ),
      body: Obx(() {
        if (controller.myProducts.isEmpty) {
          return const Center(child: Text('No products in inventory'));
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.myProducts.length,
          itemBuilder: (context, index) {
            final product = controller.myProducts[index];
            final bool isOutOfStock = !product.inStock;
            // Let's just simulate low stock for demonstration if moq is somewhat close to a dummy stock
            final bool isLowStock = !isOutOfStock && index % 3 == 0; 

            Color statusColor = Colors.green;
            String statusText = 'In Stock';
            if (isOutOfStock) {
              statusColor = Colors.red;
              statusText = 'Out of Stock';
            } else if (isLowStock) {
              statusColor = Colors.orange;
              statusText = 'Low Stock';
            }

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                          child: Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 10)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Current Stock', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              Text('${isOutOfStock ? 0 : isLowStock ? product.moq + 10 : 500} ${product.unit}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('MOQ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              Text('${product.moq} ${product.unit}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _showUpdateStockDialog(context, controller, product.id, isOutOfStock ? 0 : (isLowStock ? product.moq + 10 : 500)),
                          style: ElevatedButton.styleFrom(visualDensity: VisualDensity.compact),
                          child: const Text('Update'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showUpdateStockDialog(BuildContext context, SellerProductsController controller, String id, int currentStock) {
    final stockCtrl = TextEditingController(text: currentStock.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Stock'),
        content: TextFormField(
          controller: stockCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'New Stock Quantity', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final val = int.tryParse(stockCtrl.text) ?? 0;
              controller.updateStock(id, val);
              Get.back();
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
