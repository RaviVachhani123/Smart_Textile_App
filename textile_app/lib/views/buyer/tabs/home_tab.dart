import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../utils/dummy_data.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/category_card.dart';
import '../../../widgets/product_card.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/custom_button.dart';
import '../../../controllers/buyer_home_controller.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final featuredProducts = DummyData.products.where((p) => p.isFeatured).toList();
    final popularProducts = DummyData.products.where((p) => p.isPopular).toList();
    final newArrivals = DummyData.products.where((p) => p.isNewArrival).toList();

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Morning,', style: theme.textTheme.bodyMedium),
                      Text('Buyer Name', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
                      const CircleAvatar(
                        radius: 18,
                        child: Icon(Icons.person_outline, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Search
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomTextField(
                hintText: 'Search fabrics, products, manufacturers...',
                prefixIcon: Icons.search,
              ),
            ),
            const SizedBox(height: 24),

            // Hero Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [theme.colorScheme.primary, theme.colorScheme.tertiary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find the Right Fabric\nfor Your Business',
                      style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: theme.colorScheme.primary,
                      ),
                      child: const Text('Explore Products'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SectionHeader(
                title: 'Categories',
                onSeeAll: () {
                  final controller = Get.find<BuyerHomeController>();
                  controller.changeTab(1); // Index 1 is Categories
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: DummyData.categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(category: DummyData.categories[index]);
                },
              ),
            ),
            const SizedBox(height: 32),

            // Featured Products
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const SectionHeader(title: 'Featured Products'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 280,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: featuredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: featuredProducts[index]);
                },
              ),
            ),
            const SizedBox(height: 32),

            // AI Promotion Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.colorScheme.secondary, theme.colorScheme.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Meet Textile AI',
                            style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Get help understanding fabrics, comparing products and finding the right material.',
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            text: 'Ask Textile AI',
                            isFullWidth: false,
                            onPressed: () => Get.toNamed(AppRoutes.aiAssistant),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.smart_toy, size: 80, color: Colors.white54),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Popular Products
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const SectionHeader(title: 'Popular Products'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 280,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: popularProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: popularProducts[index]);
                },
              ),
            ),
            const SizedBox(height: 32),

            // New Arrivals
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const SectionHeader(title: 'New Arrivals'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 280,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: newArrivals.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: newArrivals[index]);
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
