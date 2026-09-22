import 'package:get/get.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  void addToCart(ProductModel product, int quantity, String? color, String? size) {
    // Generate unique ID based on product ID and variants
    final itemId = '${product.id}_${color ?? "default"}_${size ?? "default"}';
    
    final existingIndex = cartItems.indexWhere((item) => item.id == itemId);
    
    if (existingIndex >= 0) {
      // Item exists, update quantity
      final newQty = cartItems[existingIndex].quantity + quantity;
      if (newQty <= product.availableStock) {
        cartItems[existingIndex].quantity = newQty;
        cartItems.refresh();
        Get.snackbar('Cart Updated', 'Quantity updated in your cart', snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Stock Limit', 'Cannot exceed available stock', snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      // New item
      cartItems.add(CartItemModel(
        id: itemId,
        product: product,
        quantity: quantity,
        selectedColor: color,
        selectedSize: size,
      ));
      Get.snackbar('Added to Cart', '${product.name} added to your cart', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void removeFromCart(String itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
  }

  void increaseQuantity(String itemId) {
    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      final item = cartItems[index];
      if (item.quantity < item.product.availableStock) {
        item.quantity++;
        cartItems.refresh();
      } else {
        Get.snackbar('Stock Limit', 'Cannot exceed available stock of ${item.product.availableStock}', snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  void decreaseQuantity(String itemId) {
    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      final item = cartItems[index];
      if (item.quantity > item.product.moq) {
        item.quantity--;
        cartItems.refresh();
      } else {
        Get.snackbar('MOQ Limit', 'Minimum Order Quantity is ${item.product.moq}', snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  double get subtotal {
    return cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  double get estimatedShipping {
    if (cartItems.isEmpty) return 0;
    return 150.0; // Dummy fixed shipping cost
  }

  double get total => subtotal + estimatedShipping;
}
