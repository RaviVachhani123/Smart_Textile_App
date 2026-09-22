import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerSamplesScreen extends StatefulWidget {
  const SellerSamplesScreen({super.key});

  @override
  State<SellerSamplesScreen> createState() => _SellerSamplesScreenState();
}

class _SellerSamplesScreenState extends State<SellerSamplesScreen> {
  final List<Map<String, dynamic>> _samples = [
    {'buyer': 'Fashion Hub Pvt Ltd', 'product': 'Premium Cotton Fabric', 'qty': '1 meter', 'status': 'Requested'},
    {'buyer': 'Global Garments', 'product': 'Silk Blend', 'qty': '2 meters', 'status': 'Processing'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Requests'),
      ),
      body: _samples.isEmpty
          ? const Center(child: Text('No sample requests'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _samples.length,
              itemBuilder: (context, index) {
                final s = _samples[index];
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
                            Text(s['buyer'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(s['status'], style: TextStyle(color: s['status'] == 'Requested' ? Colors.orange : Colors.blue, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('Product: ${s['product']}'),
                        const SizedBox(height: 4),
                        Text('Sample Size: ${s['qty']}'),
                        const SizedBox(height: 16),
                        _buildActions(s, index),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildActions(Map<String, dynamic> s, int index) {
    if (s['status'] == 'Requested') {
      return Row(
        children: [
          Expanded(child: OutlinedButton(onPressed: () => _updateStatus(index, 'Rejected'), style: OutlinedButton.styleFrom(foregroundColor: Colors.red), child: const Text('Reject'))),
          const SizedBox(width: 16),
          Expanded(child: ElevatedButton(onPressed: () => _updateStatus(index, 'Processing'), child: const Text('Accept'))),
        ],
      );
    } else if (s['status'] == 'Processing') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(onPressed: () => _updateStatus(index, 'Shipped'), child: const Text('Mark as Shipped')),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void _updateStatus(int index, String status) {
    setState(() {
      _samples[index]['status'] = status;
    });
    Get.snackbar('Success', 'Sample request marked as $status', backgroundColor: Colors.green, colorText: Colors.white);
  }
}
