import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_list_controller.dart';
import '../../widgets/product_card.dart';
import '../../widgets/custom_text_field.dart';
import 'filter_bottom_sheet.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // If a category was passed as an argument, set it automatically.
    final passedCategory = Get.arguments as String?;
    final controller = Get.put(ProductListController());
    
    if (passedCategory != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.setCategoryFilter(passedCategory);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          controller.selectedCategory.value.isEmpty 
              ? 'All Products' 
              : '${controller.selectedCategory.value} Products'
        )),
        actions: [
          Obx(() => IconButton(
            icon: Icon(controller.isGridFormat.value ? Icons.list : Icons.grid_view),
            onPressed: controller.toggleFormat,
            tooltip: 'Toggle View',
          )),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              Get.bottomSheet(const FilterBottomSheet(), isScrollControlled: true);
            },
            tooltip: 'Filter & Sort',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              hintText: 'Search textile products...',
              prefixIcon: Icons.search,
              onChanged: controller.searchProducts,
            ),
          ),
          Obx(() {
            if (controller.compareList.isNotEmpty) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${controller.compareList.length} items selected to compare', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: () {
                        // Compare action for future phase
                        Get.snackbar('Compare', 'Compare functionality coming soon!');
                      },
                      child: const Text('Compare Now'),
                    )
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          Expanded(
            child: Obx(() {
              if (controller.filteredProducts.isEmpty) {
                return const Center(child: Text('No products found.'));
              }
              
              if (controller.isGridFormat.value) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.55,
                  ),
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];
                    return Obx(() => ProductCard(
                      product: product,
                      isListFormat: false,
                      isCompareSelected: controller.compareList.contains(product.id),
                      onCompareChanged: () => controller.toggleCompare(product.id),
                    ));
                  },
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];
                    return Obx(() => ProductCard(
                      product: product,
                      isListFormat: true,
                      isCompareSelected: controller.compareList.contains(product.id),
                      onCompareChanged: () => controller.toggleCompare(product.id),
                    ));
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
