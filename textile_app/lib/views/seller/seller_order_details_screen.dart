import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/seller_orders_controller.dart';

class SellerOrderDetailsScreen extends StatelessWidget {
  const SellerOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SellerOrder order = Get.arguments;
    final controller = Get.find<SellerOrdersController>();
    final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    final dateStr = DateFormat('MMM dd, yyyy - hh:mm a').format(order.date);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.id}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Obx(() {
                  // We need to look up the order dynamically to get state updates
                  final currentOrder = controller.allOrders.firstWhere((o) => o.id == order.id, orElse: () => order);
                  return Chip(
                    label: Text(currentOrder.status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    backgroundColor: _getStatusColor(currentOrder.status),
                  );
                }),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            const Text('Buyer Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(order.buyerName, style: const TextStyle(fontSize: 16)),
            const Text('contact@fashionhub.com\n+91 9876543210', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            const Text('Delivery Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('123 Textile Market,\nRing Road, Surat, Gujarat 395002', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            const Text('Order Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: Text(order.productInfo),
                subtitle: const Text('Quantity: As per product info'),
                trailing: Text(formatter.format(order.amount), style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Order Date:', style: TextStyle(color: Colors.grey)),
                Text(dateStr, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Amount:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(formatter.format(order.amount), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Obx(() {
              final currentOrder = controller.allOrders.firstWhere((o) => o.id == order.id, orElse: () => order);
              if (currentOrder.status == 'New') {
                return Row(
                  children: [
                    Expanded(child: ElevatedButton(onPressed: () => controller.updateOrderStatus(order.id, 'Processing'), child: const Text('Accept & Process'))),
                    const SizedBox(width: 16),
                    Expanded(child: OutlinedButton(onPressed: () => controller.updateOrderStatus(order.id, 'Cancelled'), child: const Text('Reject Order', style: TextStyle(color: Colors.red)))),
                  ],
                );
              } else if (currentOrder.status == 'Processing') {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () => controller.updateOrderStatus(order.id, 'Shipped'), child: const Text('Mark as Shipped')),
                );
              } else if (currentOrder.status == 'Shipped') {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () => controller.updateOrderStatus(order.id, 'Delivered'), child: const Text('Mark as Delivered')),
                );
              }
              return Center(child: Text('No actions available for ${currentOrder.status} orders.'));
            }),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'New': return Colors.blue;
      case 'Processing': return Colors.orange;
      case 'Shipped': return Colors.purple;
      case 'Delivered': return Colors.green;
      case 'Cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }
}
