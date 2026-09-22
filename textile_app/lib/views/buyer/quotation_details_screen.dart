import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/quotation_controller.dart';
import '../../app/routes/app_routes.dart';

class QuotationDetailsScreen extends StatelessWidget {
  const QuotationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String quoteId = Get.arguments as String;
    final controller = Get.find<QuotationController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotation Details'),
      ),
      body: Obx(() {
        final quoteIndex = controller.quotations.indexWhere((q) => q.id == quoteId);
        if (quoteIndex == -1) return const Center(child: Text('Quotation not found'));
        final quote = controller.quotations[quoteIndex];

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Status', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                              Text(quote.status, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.colorScheme.primary)),
                            ],
                          ),
                          Text(quote.createdAt.toLocal().toString().split(' ')[0]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Product details
                    const Text('Product Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                              Text(quote.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(quote.product.seller, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Price comparison
                    const Text('Pricing & Terms', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    Table(
                      border: TableBorder.all(color: Colors.grey.withValues(alpha: 0.3)),
                      children: [
                        _buildTableRow('Required Quantity', '${quote.requiredQuantity} ${quote.product.unit}'),
                        _buildTableRow('Your Target Price', '₹${quote.targetPrice}'),
                        _buildTableRow('Seller Offered Price', quote.sellerOfferedPrice != null ? '₹${quote.sellerOfferedPrice}' : 'Awaiting Quote'),
                        _buildTableRow('Required Delivery', quote.deliveryDate.toLocal().toString().split(' ')[0]),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Initial Message
                    const Text('Initial Message', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(quote.initialMessage),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Actions
            if (quote.status != 'Accepted' && quote.status != 'Rejected')
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -2))
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => controller.rejectQuote(quote.id),
                        style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                        child: const Text('Reject'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(AppRoutes.negotiation, arguments: quote.id),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                        child: const Text('Negotiate'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => controller.acceptQuote(quote.id),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                        child: const Text('Accept'),
                      ),
                    ),
                  ],
                ),
              ),
          ],
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
