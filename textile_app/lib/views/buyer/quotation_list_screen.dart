import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/quotation_controller.dart';
import '../../app/routes/app_routes.dart';

class QuotationListScreen extends StatelessWidget {
  const QuotationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuotationController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Quotations'),
      ),
      body: Obx(() {
        if (controller.quotations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.request_quote_outlined, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text('No quotations requested yet', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.quotations.length,
          itemBuilder: (context, index) {
            final quote = controller.quotations[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () => Get.toNamed(AppRoutes.quotationDetails, arguments: quote.id),
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
                              quote.product.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _buildStatusBadge(quote.status, theme),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _infoBlock('Quantity', '${quote.requiredQuantity} ${quote.product.unit}'),
                          _infoBlock('Target', '₹${quote.targetPrice}'),
                          _infoBlock('Offered', quote.sellerOfferedPrice != null ? '₹${quote.sellerOfferedPrice}' : '--'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text('Delivery: ${quote.deliveryDate.toLocal().toString().split(' ')[0]}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          const Spacer(),
                          Text(quote.product.seller, style: TextStyle(color: theme.colorScheme.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      )
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

  Widget _infoBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildStatusBadge(String status, ThemeData theme) {
    Color bgColor;
    Color textColor = Colors.white;

    switch (status) {
      case 'Accepted':
        bgColor = Colors.green;
        break;
      case 'Rejected':
        bgColor = Colors.red;
        break;
      case 'Negotiating':
        bgColor = Colors.orange;
        break;
      case 'Received':
        bgColor = Colors.blue;
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
        style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
