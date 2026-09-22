import 'package:get/get.dart';
import '../models/product_model.dart';

class WishlistController extends GetxController {
  final RxList<ProductModel> wishlistItems = <ProductModel>[].obs;

  bool isInWishlist(ProductModel product) {
    return wishlistItems.any((item) => item.id == product.id);
  }

  void toggleWishlist(ProductModel product) {
    if (isInWishlist(product)) {
      wishlistItems.removeWhere((item) => item.id == product.id);
      Get.snackbar('Wishlist', 'Removed from wishlist', snackPosition: SnackPosition.BOTTOM);
    } else {
      wishlistItems.add(product);
      Get.snackbar('Wishlist', 'Added to wishlist', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
