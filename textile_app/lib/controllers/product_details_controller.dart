import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductDetailsController extends GetxController {
  final ProductModel product;

  var currentImageIndex = 0.obs;
  var selectedColor = ''.obs;
  var selectedSize = ''.obs;
  var quantity = 0.obs;

  ProductDetailsController(this.product) {
    if (product.availableColors.isNotEmpty) {
      selectedColor.value = product.availableColors.first;
    }
    if (product.availableSizes.isNotEmpty) {
      selectedSize.value = product.availableSizes.first;
    }
    quantity.value = product.moq;
  }

  void setImageIndex(int index) {
    currentImageIndex.value = index;
  }

  void setColor(String color) {
    selectedColor.value = color;
  }

  void setSize(String size) {
    selectedSize.value = size;
  }

  void incrementQuantity() {
    if (quantity.value < product.availableStock) {
      quantity.value++;
    } else {
      Get.snackbar('Stock Limit', 'Cannot exceed available stock of ${product.availableStock}.', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void decrementQuantity() {
    if (quantity.value > product.moq) {
      quantity.value--;
    } else {
      Get.snackbar('MOQ Limit', 'Minimum Order Quantity is ${product.moq}.', snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool get isValidQuantity => quantity.value >= product.moq && quantity.value <= product.availableStock;
}
