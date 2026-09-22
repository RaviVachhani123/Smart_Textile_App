import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';

class SellerQuotationsScreen extends StatelessWidget {
  const SellerQuotationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy quotes for now
    final quotes = [
      {'buyer': 'Fashion Hub Pvt Ltd', 'status': 'Pending', 'product': 'Premium Cotton Fabric', 'qty': '500 meters', 'target': '₹140/m'},
      {'buyer': 'Zara Textiles', 'status': 'Negotiating', 'product': 'Silk Blend', 'qty': '200 meters', 'target': '₹200/m'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotations'),
      ),
      body: quotes.isEmpty
          ? const Center(child: Text('No quotation requests'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                final q = quotes[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(q['buyer']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(q['status']!, style: TextStyle(color: q['status'] == 'Pending' ? Colors.orange : Colors.blue, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('Product: ${q['product']}'),
                        const SizedBox(height: 4),
                        Text('Required: ${q['qty']}'),
                        const SizedBox(height: 4),
                        Text('Target Price: ${q['target']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Get.snackbar('Rejected', 'Quotation request rejected', backgroundColor: Colors.red, colorText: Colors.white);
                                },
                                style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                                child: const Text('Reject'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.sellerNegotiation);
                                },
                                child: const Text('Respond'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
