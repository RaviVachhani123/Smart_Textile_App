import 'package:flutter/material.dart';

class SellerAnalyticsScreen extends StatelessWidget {
  const SellerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Sales Overview (This Month)', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildMetricCard('Gross Revenue', '₹4.5L', Colors.green)),
              const SizedBox(width: 16),
              Expanded(child: _buildMetricCard('Total Orders', '124', Colors.blue)),
            ],
          ),
          const SizedBox(height: 32),
          
          Text('Top Performing Products', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(child: Text('1')),
                  title: Text('Premium Cotton Fabric'),
                  trailing: Text('₹1.2L', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Divider(height: 1),
                ListTile(
                  leading: CircleAvatar(child: Text('2')),
                  title: Text('Silk Blend'),
                  trailing: Text('₹85K', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          Text('Inventory Insights', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Card(
            color: Colors.orange.withValues(alpha: 0.1),
            child: const ListTile(
              leading: Icon(Icons.warning, color: Colors.orange),
              title: Text('2 Products Low on Stock', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Silk Blend, Linen Fabric are below MOQ levels.'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
