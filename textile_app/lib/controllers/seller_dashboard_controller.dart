import 'package:get/get.dart';
import '../models/product_model.dart';
import '../utils/dummy_data.dart';

class SellerDashboardController extends GetxController {
  final RxInt totalProducts = 0.obs;
  final RxInt totalOrders = 0.obs;
  final RxInt pendingOrders = 0.obs;
  final RxDouble totalRevenue = 0.0.obs;
  
  final RxList<ProductModel> lowStockProducts = <ProductModel>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }
  
  void _loadDummyData() {
    totalProducts.value = DummyData.products.length;
    totalOrders.value = 124;
    pendingOrders.value = 12;
    totalRevenue.value = 450000.0;
    
    // Simulate low stock
    lowStockProducts.assignAll(
      DummyData.products.where((p) => p.inStock && p.id == 'p2').toList()
    );
  }
}
