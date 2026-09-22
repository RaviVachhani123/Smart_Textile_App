import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/seller_orders_controller.dart';
import '../../../app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class SellerOrdersTab extends StatelessWidget {
  const SellerOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerOrdersController());
    final statuses = ['All', 'New', 'Processing', 'Shipped', 'Delivered', 'Cancelled'];

    return DefaultTabController(
      length: statuses.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Management'),
          bottom: TabBar(
            isScrollable: true,
            tabs: statuses.map((s) => Tab(text: s)).toList(),
          ),
        ),
        body: TabBarView(
          children: statuses.map((status) {
            return Obx(() {
              final orders = controller.getOrdersByStatus(status);
              
              if (orders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No $status orders found',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'When you receive new orders, they will appear here.',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
                  final dateStr = DateFormat('MMM dd, yyyy').format(order.date);

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.sellerOrderDetails, arguments: order);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Order #${order.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(order.status).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(order.status, style: TextStyle(color: _getStatusColor(order.status), fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(order.productInfo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text('Buyer: ${order.buyerName}', style: TextStyle(color: Colors.grey[700])),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(dateStr, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                                Text(formatter.format(order.amount), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            });
          }).toList(),
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

