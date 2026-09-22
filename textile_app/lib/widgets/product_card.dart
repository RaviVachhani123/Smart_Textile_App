import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../controllers/wishlist_controller.dart';
import '../app/routes/app_routes.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool isListFormat;
  final VoidCallback? onCompareChanged;
  final bool isCompareSelected;

  const ProductCard({
    super.key,
    required this.product,
    this.isListFormat = false,
    this.onCompareChanged,
    this.isCompareSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isListFormat) {
      return _buildListFormat(context);
    }
    return _buildGridFormat(context);
  }

  Widget _buildGridFormat(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.productDetails, arguments: product),
      borderRadius: BorderRadius.circular(12),
      child: Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: product.imageUrl.startsWith('http') 
              ? Image.network(product.imageUrl, fit: BoxFit.cover, errorBuilder: (c, e, s) => Icon(Icons.inventory_2_outlined, color: Colors.grey[400], size: 40))
              : Image.asset(product.imageUrl, fit: BoxFit.cover, errorBuilder: (c, e, s) => Icon(Icons.inventory_2_outlined, color: Colors.grey[400], size: 40)),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14,
                    child: Obx(() {
                      final inWishlist = Get.find<WishlistController>().isInWishlist(product);
                      return GestureDetector(
                        onTap: () => Get.find<WishlistController>().toggleWishlist(product),
                        child: Icon(
                          inWishlist ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: inWishlist ? Colors.red : Theme.of(context).colorScheme.primary,
                        ),
                      );
                    }),
                  ),
                ),
                if (!product.inStock)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('Out of Stock', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ),
              ],
            ),
          ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Text(
                    product.category,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${product.price} / ${product.unit}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'GSM: ${product.gsm}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        'MOQ: ${product.moq}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          product.seller,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          Text(
                            product.rating.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      )
                    ],
                  ),
                  if (onCompareChanged != null) ...[
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 24,
                      child: Row(
                        children: [
                          Checkbox(
                            value: isCompareSelected,
                            onChanged: (_) => onCompareChanged!(),
                            visualDensity: VisualDensity.compact,
                          ),
                          const Text('Compare', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    )
                  ]
                ],
              ),
            ),
        ],
      ),
      ),
    );
  }

  Widget _buildListFormat(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.productDetails, arguments: product),
      borderRadius: BorderRadius.circular(12),
      child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
            child: Stack(
              children: [
                Container(
                  height: 140,
                  width: 120,
                  color: Colors.grey[200],
                  child: product.imageUrl.startsWith('http') 
              ? Image.network(product.imageUrl, fit: BoxFit.cover, errorBuilder: (c, e, s) => Icon(Icons.inventory_2_outlined, color: Colors.grey[400], size: 40))
              : Image.asset(product.imageUrl, fit: BoxFit.cover, errorBuilder: (c, e, s) => Icon(Icons.inventory_2_outlined, color: Colors.grey[400], size: 40)),
                ),
                if (!product.inStock)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('Out of Stock', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ),
              ],
            ),
          ),
          // Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.category,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Obx(() {
                        final inWishlist = Get.find<WishlistController>().isInWishlist(product);
                        return GestureDetector(
                          onTap: () => Get.find<WishlistController>().toggleWishlist(product),
                          child: Icon(
                            inWishlist ? Icons.favorite : Icons.favorite_border,
                            size: 20,
                            color: inWishlist ? Colors.red : Theme.of(context).colorScheme.primary,
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${product.price} / ${product.unit}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('GSM: ${product.gsm}', style: Theme.of(context).textTheme.bodySmall),
                      Text('MOQ: ${product.moq}', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.seller,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          Text(product.rating.toString(), style: Theme.of(context).textTheme.bodySmall),
                        ],
                      )
                    ],
                  ),
                  if (onCompareChanged != null) ...[
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 24,
                      child: Row(
                        children: [
                          Checkbox(
                            value: isCompareSelected,
                            onChanged: (_) => onCompareChanged!(),
                            visualDensity: VisualDensity.compact,
                          ),
                          const Text('Compare', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
