import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/sample_controller.dart';

class SampleDetailsScreen extends StatelessWidget {
  const SampleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String reqId = Get.arguments as String;
    final controller = Get.find<SampleController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Request Details'),
      ),
      body: Obx(() {
        final reqIndex = controller.sampleRequests.indexWhere((r) => r.id == reqId);
        if (reqIndex == -1) return const Center(child: Text('Request not found'));
        final req = controller.sampleRequests[reqIndex];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline/Status Badge
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      req.status == 'Delivered' ? Icons.check_circle : Icons.local_shipping,
                      size: 64,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Status: ${req.status}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Requested on ${req.createdAt.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Product details
              const Text('Product Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: const Icon(Icons.inventory_2_outlined),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(req.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(req.product.seller, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 32),
              
              const Text('Request Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Table(
                border: TableBorder.all(color: Colors.grey.withValues(alpha: 0.3)),
                children: [
                  _buildTableRow('Quantity', '${req.quantity}'),
                  _buildTableRow('Color/Variant', req.color),
                  _buildTableRow('Delivery Address', req.address),
                  _buildTableRow('Notes', req.notes.isEmpty ? 'None' : req.notes),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(value),
        ),
      ],
    );
  }
}
