import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/sample_controller.dart';
import '../../app/routes/app_routes.dart';

class SampleListScreen extends StatelessWidget {
  const SampleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SampleController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Sample Requests'),
      ),
      body: Obx(() {
        if (controller.sampleRequests.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text('No sample requests yet', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.sampleRequests.length,
          itemBuilder: (context, index) {
            final req = controller.sampleRequests[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () => Get.toNamed(AppRoutes.sampleDetails, arguments: req.id),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              req.product.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _buildStatusBadge(req.status, theme),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(req.product.seller, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Qty: ${req.quantity}', style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text('Color: ${req.color}', style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text(req.createdAt.toLocal().toString().split(' ')[0], style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildStatusBadge(String status, ThemeData theme) {
    Color bgColor;

    switch (status) {
      case 'Accepted':
      case 'Processing':
      case 'Shipped':
        bgColor = Colors.blue;
        break;
      case 'Delivered':
        bgColor = Colors.green;
        break;
      case 'Rejected':
        bgColor = Colors.red;
        break;
      default:
        bgColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
