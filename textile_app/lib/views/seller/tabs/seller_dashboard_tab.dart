import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../controllers/seller_dashboard_controller.dart';
import '../../../controllers/seller_home_controller.dart';
import '../../../app/routes/app_routes.dart';

class SellerDashboardTab extends StatelessWidget {
  const SellerDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerDashboardController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Dashboard'),
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Grid
            Obx(() => GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.5,
                  children: [
                    _buildKpiCard('Total Revenue', '₹${controller.totalRevenue.value.toStringAsFixed(0)}', Icons.account_balance_wallet, Colors.green),
                    _buildKpiCard('Total Orders', '${controller.totalOrders.value}', Icons.receipt_long, Colors.blue),
                    _buildKpiCard('Pending Orders', '${controller.pendingOrders.value}', Icons.pending_actions, Colors.orange),
                    _buildKpiCard('Total Products', '${controller.totalProducts.value}', Icons.inventory_2, Colors.purple),
                  ],
                )),
            
            const SizedBox(height: 32),
            
            // Low Stock Alerts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Low Stock Alerts', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('View All')),
              ],
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (controller.lowStockProducts.isEmpty) {
                return const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('All products have sufficient stock.')));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.lowStockProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.lowStockProducts[index];
                  return Card(
                    child: ListTile(
                      leading: Container(
                        width: 40, height: 40, color: Colors.grey[200],
                        child: const Icon(Icons.inventory_2_outlined),
                      ),
                      title: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text('Current Stock: 10 ${product.unit}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(visualDensity: VisualDensity.compact),
                        child: const Text('Update'),
                      ),
                    ),
                  );
                },
              );
            }),
            
            const SizedBox(height: 32),
            Text('Quick Actions', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildQuickAction('Add Product', Icons.add_box, Colors.blue, () => Get.toNamed(AppRoutes.sellerAddProduct)),
                _buildQuickAction('Inventory', Icons.inventory, Colors.green, () => Get.toNamed(AppRoutes.sellerInventory)),
                _buildQuickAction('Quotations', Icons.request_quote, Colors.orange, () => Get.toNamed(AppRoutes.sellerQuotations)),
                _buildQuickAction('Samples', Icons.science, Colors.purple, () => Get.toNamed(AppRoutes.sellerSamples)),
                _buildQuickAction('Messages', Icons.message, Colors.teal, () {
                  final homeCtrl = Get.find<SellerHomeController>();
                  homeCtrl.changeTab(3); // Switch to Messages tab
                }),
                _buildQuickAction('Analytics', Icons.analytics, Colors.red, () => Get.toNamed(AppRoutes.sellerAnalytics)),
              ],
            ),
            
            const SizedBox(height: 32),
            Text('Recent Orders', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Card(
              child: ListTile(
                title: Text('Order #10294 - pending'),
                subtitle: Text('Buyer: Fashion Hub Pvt Ltd\nAmount: ₹12,500'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            
            const SizedBox(height: 32),
            Text('Recent Quotation Requests', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Card(
              child: ListTile(
                title: Text('Premium Cotton Fabric - 500m'),
                subtitle: Text('Target: ₹140/m (Waiting your response)'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1)),
            ],
          ),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
