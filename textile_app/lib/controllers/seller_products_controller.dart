import 'package:get/get.dart';
import '../models/product_model.dart';
import '../utils/dummy_data.dart';

class SellerProductsController extends GetxController {
  final RxList<ProductModel> myProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    myProducts.assignAll(DummyData.products);
  }

  void addProduct(ProductModel product) {
    myProducts.insert(0, product);
    Get.snackbar('Success', 'Product added successfully', snackPosition: SnackPosition.BOTTOM);
  }

  void editProduct(String id, ProductModel updatedProduct) {
    final index = myProducts.indexWhere((p) => p.id == id);
    if (index != -1) {
      myProducts[index] = updatedProduct;
      myProducts.refresh();
      Get.snackbar('Success', 'Product updated successfully', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void deleteProduct(String id) {
    myProducts.removeWhere((p) => p.id == id);
    Get.snackbar('Deleted', 'Product has been removed', snackPosition: SnackPosition.BOTTOM);
  }
  
  void updateStock(String id, int newStock) {
    final index = myProducts.indexWhere((p) => p.id == id);
    if (index != -1) {
      // Create a copy with updated stock logic (if we had a stock field). 
      // For dummy purposes, we'll just toggle inStock based on value.
      final p = myProducts[index];
      myProducts[index] = ProductModel(
        id: p.id,
        name: p.name,
        category: p.category,
        description: p.description,
        price: p.price,
        unit: p.unit,
        imageUrl: p.imageUrl,
        seller: p.seller,
        rating: p.rating,
        moq: p.moq,
        inStock: newStock > 0,
        gsm: p.gsm,
        materialComposition: p.materialComposition,
        availableColors: p.availableColors,
      );
      myProducts.refresh();
      Get.snackbar('Stock Updated', 'Inventory levels adjusted', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
