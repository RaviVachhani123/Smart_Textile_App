import 'package:get/get.dart';
import '../models/product_model.dart';
import '../utils/dummy_data.dart';

class ProductListController extends GetxController {
  var isGridFormat = true.obs;
  
  var allProducts = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;
  
  var searchQuery = ''.obs;
  
  // Compare State
  var compareList = <String>[].obs;

  // Filter State
  var selectedCategory = ''.obs;
  var selectedSort = 'Newest'.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Default load all products
    allProducts.assignAll(DummyData.products);
    filteredProducts.assignAll(DummyData.products);
  }

  void toggleFormat() {
    isGridFormat.value = !isGridFormat.value;
  }

  void toggleCompare(String productId) {
    if (compareList.contains(productId)) {
      compareList.remove(productId);
    } else {
      if (compareList.length < 3) {
        compareList.add(productId);
      } else {
        Get.snackbar('Limit Reached', 'You can only compare up to 3 products at a time.', snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void setCategoryFilter(String category) {
    selectedCategory.value = category;
    applyFilters();
  }

  void setSortMode(String mode) {
    selectedSort.value = mode;
    applyFilters();
  }

  void applyFilters() {
    List<ProductModel> result = allProducts.toList();

    // 1. Search Filter (Name, Category, Fabric Type, Seller)
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      result = result.where((p) =>
          p.name.toLowerCase().contains(query) ||
          p.category.toLowerCase().contains(query) ||
          p.seller.toLowerCase().contains(query)).toList();
    }

    // 2. Category Filter
    if (selectedCategory.value.isNotEmpty) {
      result = result.where((p) => p.category == selectedCategory.value).toList();
    }

    // 3. Sorting
    switch (selectedSort.value) {
      case 'Price: Low to High':
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'MOQ':
        result.sort((a, b) => a.moq.compareTo(b.moq));
        break;
      case 'Newest':
      default:
        // Mock newest (using isNewArrival flag or ID)
        result.sort((a, b) => (b.isNewArrival ? 1 : 0).compareTo(a.isNewArrival ? 1 : 0));
        break;
    }

    filteredProducts.assignAll(result);
  }
  
  void clearFilters() {
    selectedCategory.value = '';
    searchQuery.value = '';
    selectedSort.value = 'Newest';
    applyFilters();
  }
}
