import 'product_model.dart';

class CartItemModel {
  final String id;
  final ProductModel product;
  int quantity;
  final String? selectedColor;
  final String? selectedSize;

  CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    this.selectedColor,
    this.selectedSize,
  });
}
