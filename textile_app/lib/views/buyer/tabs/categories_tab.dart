import 'package:flutter/material.dart';
import '../../../utils/dummy_data.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/category_card.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Categories',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextField(
              hintText: 'Search categories...',
              prefixIcon: Icons.search,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: DummyData.categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: DummyData.categories[index],
                  isHorizontal: false, // Use grid style
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
