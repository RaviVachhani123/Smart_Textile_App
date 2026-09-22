import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../app/routes/app_routes.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final bool isHorizontal;

  const CategoryCard({
    super.key,
    required this.category,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return InkWell(
        onTap: () => Get.toNamed(AppRoutes.productList, arguments: category.name),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          child: Column(
            children: [
              ClipOval(
                child: Container(
                  width: 60, height: 60,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  child: category.imageUrl.startsWith('http')
                    ? Image.network(category.imageUrl, fit: BoxFit.cover, errorBuilder: (c, e, s) => Icon(Icons.category, color: Theme.of(context).colorScheme.primary))
                    : Image.asset(category.imageUrl, fit: BoxFit.cover, errorBuilder: (c, e, s) => Icon(Icons.category, color: Theme.of(context).colorScheme.primary)),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Grid style
      return InkWell(
        onTap: () => Get.toNamed(AppRoutes.productList, arguments: category.name),
        borderRadius: BorderRadius.circular(12),
        child: Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  width: 80, height: 80,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  child: category.imageUrl.startsWith('http')
                    ? Image.network(category.imageUrl, fit: BoxFit.cover, errorBuilder: (c, e, s) => Icon(Icons.category, color: Theme.of(context).colorScheme.primary, size: 32))
                    : Image.asset(category.imageUrl, fit: BoxFit.cover, errorBuilder: (c, e, s) => Icon(Icons.category, color: Theme.of(context).colorScheme.primary, size: 32)),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                category.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '${category.productCount} Products',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
