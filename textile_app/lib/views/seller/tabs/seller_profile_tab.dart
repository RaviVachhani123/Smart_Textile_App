import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class SellerProfileTab extends StatelessWidget {
  const SellerProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text('ST', style: TextStyle(fontSize: 32, color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                        child: const Icon(Icons.verified, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Surat Textiles Pvt Ltd', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('Owner: Rajesh Kumar', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('Verified Wholesaler', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text('Business Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          const Card(
            child: Column(
              children: [
                ListTile(leading: Icon(Icons.email), title: Text('Email'), subtitle: Text('contact@surattextiles.com')),
                Divider(height: 1),
                ListTile(leading: Icon(Icons.phone), title: Text('Phone'), subtitle: Text('+91 98765 43210')),
                Divider(height: 1),
                ListTile(leading: Icon(Icons.location_on), title: Text('Address'), subtitle: Text('Ring Road, Surat, Gujarat 395002')),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Settings & More', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(leading: const Icon(Icons.analytics_outlined), title: const Text('Analytics Dashboard'), trailing: const Icon(Icons.chevron_right), onTap: () => Get.toNamed(AppRoutes.sellerAnalytics)),
                const Divider(height: 1),
                ListTile(leading: const Icon(Icons.inventory_outlined), title: const Text('Inventory Management'), trailing: const Icon(Icons.chevron_right), onTap: () => Get.toNamed(AppRoutes.sellerInventory)),
                const Divider(height: 1),
                const ListTile(leading: Icon(Icons.settings), title: Text('Account Settings'), trailing: Icon(Icons.chevron_right)),
                const Divider(height: 1),
                const ListTile(leading: Icon(Icons.help_outline), title: Text('Help & Support'), trailing: Icon(Icons.chevron_right)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Get.offAllNamed(AppRoutes.login),
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
          ),
        ],
      ),
    );
  }
}
