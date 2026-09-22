import 'package:get/get.dart';

class SellerOrder {
  final String id;
  final String buyerName;
  final String productInfo;
  final double amount;
  final DateTime date;
  String status;

  SellerOrder({
    required this.id,
    required this.buyerName,
    required this.productInfo,
    required this.amount,
    required this.date,
    required this.status,
  });
}

class SellerOrdersController extends GetxController {
  final RxList<SellerOrder> allOrders = <SellerOrder>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyOrders();
  }

  void _loadDummyOrders() {
    allOrders.addAll([
      SellerOrder(id: '10294', buyerName: 'Fashion Hub Pvt Ltd', productInfo: '500m Premium Cotton', amount: 45000, date: DateTime.now().subtract(const Duration(hours: 2)), status: 'New'),
      SellerOrder(id: '10295', buyerName: 'Zara Textiles', productInfo: '200m Silk Blend', amount: 32000, date: DateTime.now().subtract(const Duration(hours: 5)), status: 'New'),
      SellerOrder(id: '10291', buyerName: 'Global Garments', productInfo: '1000m Linen', amount: 85000, date: DateTime.now().subtract(const Duration(days: 1)), status: 'Processing'),
      SellerOrder(id: '10288', buyerName: 'Boutique Creations', productInfo: '300m Rayon', amount: 15000, date: DateTime.now().subtract(const Duration(days: 2)), status: 'Shipped'),
      SellerOrder(id: '10280', buyerName: 'Urban Wear', productInfo: '150m Denim', amount: 22500, date: DateTime.now().subtract(const Duration(days: 4)), status: 'Delivered'),
      SellerOrder(id: '10279', buyerName: 'Classic Tailors', productInfo: '50m Velvet', amount: 9000, date: DateTime.now().subtract(const Duration(days: 5)), status: 'Cancelled'),
    ]);
  }

  List<SellerOrder> getOrdersByStatus(String status) {
    if (status == 'All') return allOrders;
    return allOrders.where((o) => o.status == status).toList();
  }

  void updateOrderStatus(String id, String newStatus) {
    final index = allOrders.indexWhere((o) => o.id == id);
    if (index != -1) {
      allOrders[index].status = newStatus;
      allOrders.refresh();
      Get.snackbar('Success', 'Order #$id marked as $newStatus', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
