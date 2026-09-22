import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_details_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/wishlist_controller.dart';
import '../../models/product_model.dart';
import '../../widgets/product_card.dart';
import '../../utils/dummy_data.dart';
import '../../app/routes/app_routes.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments;
    final controller = Get.put(ProductDetailsController(product));
    final theme = Theme.of(context);

    // Dummy images for carousel
    final images = [
      product.imageUrl,
      'https://via.placeholder.com/400x400.png?text=Side+View',
      'https://via.placeholder.com/400x400.png?text=Texture+View'
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar & Image Carousel
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            actions: [
              Obx(() {
                final inWishlist = Get.find<WishlistController>().isInWishlist(product);
                return IconButton(
                  icon: Icon(inWishlist ? Icons.favorite : Icons.favorite_border, color: inWishlist ? Colors.red : null),
                  onPressed: () => Get.find<WishlistController>().toggleWishlist(product),
                );
              }),
              IconButton(icon: const Icon(Icons.share), onPressed: () {}),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  PageView.builder(
                    itemCount: images.length,
                    onPageChanged: controller.setImageIndex,
                    itemBuilder: (context, index) {
                      // Using a dummy container instead of NetworkImage to prevent ANRs
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.inventory_2_outlined, color: Colors.grey[400], size: 100),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: controller.currentImageIndex.value == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.currentImageIndex.value == index ? theme.colorScheme.primary : Colors.grey.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    )),
                  ),
                ],
              ),
            ),
          ),
          
          // Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name & Rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text('${product.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('${product.reviewCount} Reviews', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  
                  const SizedBox(height: 16),
                  // Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${product.price}', style: theme.textTheme.headlineMedium?.copyWith(color: Colors.green[700], fontWeight: FontWeight.bold)),
                      Text(' / ${product.unit}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey)),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  // Seller Info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1), child: const Icon(Icons.store)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(product.seller, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 4),
                                  if (product.isVerifiedSeller)
                                    const Icon(Icons.verified, color: Colors.blue, size: 16),
                                ],
                              ),
                              const Text('Textile Manufacturer', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(visualDensity: VisualDensity.compact),
                          child: const Text('Chat'),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  // Variants (Color)
                  if (product.availableColors.isNotEmpty) ...[
                    Text('Color', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Obx(() => Wrap(
                      spacing: 8,
                      children: product.availableColors.map((color) {
                        final isSelected = controller.selectedColor.value == color;
                        return ChoiceChip(
                          label: Text(color),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            if (selected) controller.setColor(color);
                          },
                        );
                      }).toList(),
                    )),
                    const SizedBox(height: 16),
                  ],

                  // Variants (Size)
                  if (product.availableSizes.isNotEmpty) ...[
                    Text('Width / Size', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Obx(() => Wrap(
                      spacing: 8,
                      children: product.availableSizes.map((size) {
                        final isSelected = controller.selectedSize.value == size;
                        return ChoiceChip(
                          label: Text(size),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            if (selected) controller.setSize(size);
                          },
                        );
                      }).toList(),
                    )),
                    const SizedBox(height: 24),
                  ],

                  // Quantity Selector
                  Text('Quantity', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(icon: const Icon(Icons.remove), onPressed: controller.decrementQuantity),
                            Obx(() => SizedBox(
                              width: 50,
                              child: Text(
                                '${controller.quantity.value}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            )),
                            IconButton(icon: const Icon(Icons.add), onPressed: controller.incrementQuantity),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MOQ: ${product.moq} ${product.unit}s', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('${product.availableStock} available', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  // B2B Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => Get.toNamed(AppRoutes.quotationRequest, arguments: product),
                          icon: const Icon(Icons.request_quote),
                          label: const Text('Request Quote'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => Get.toNamed(AppRoutes.sampleRequest, arguments: product),
                          icon: const Icon(Icons.inventory_2_outlined),
                          label: const Text('Request Sample'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: theme.colorScheme.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // AI Assistant Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [theme.colorScheme.primary, theme.colorScheme.tertiary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: Colors.white, size: 40),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Ask About This Product', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 4),
                              Text('Need help understanding this fabric?', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12)),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Get.toNamed(AppRoutes.aiAssistant, arguments: product),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: theme.colorScheme.primary,
                          ),
                          child: const Text('Ask Textile AI'),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  // Tech Specs
                  Text('Technical Specifications', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Table(
                    border: TableBorder.all(color: Colors.grey.withValues(alpha: 0.3)),
                    children: [
                      _buildTableRow('Fabric Type', product.category),
                      _buildTableRow('Material Composition', product.materialComposition),
                      _buildTableRow('GSM', '${product.gsm}'),
                      _buildTableRow('Width', product.width),
                      _buildTableRow('Pattern', product.pattern),
                      _buildTableRow('Finish', product.finish),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  // Description
                  Text('Description', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(product.description, style: const TextStyle(height: 1.5)),
                  
                  const SizedBox(height: 32),
                  // Related Products
                  Text('Related Products', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ProductCard(product: DummyData.products[index % DummyData.products.length]);
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 80), // padding for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5))],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.find<CartController>().addToCart(
                      product, 
                      controller.quantity.value, 
                      controller.selectedColor.value.isEmpty ? null : controller.selectedColor.value,
                      controller.selectedSize.value.isEmpty ? null : controller.selectedSize.value,
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Buy Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(12.0), child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: const EdgeInsets.all(12.0), child: Text(value)),
      ],
    );
  }
}
