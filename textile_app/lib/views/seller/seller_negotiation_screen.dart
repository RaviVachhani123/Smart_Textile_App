import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerNegotiationScreen extends StatefulWidget {
  const SellerNegotiationScreen({super.key});

  @override
  State<SellerNegotiationScreen> createState() => _SellerNegotiationScreenState();
}

class _SellerNegotiationScreenState extends State<SellerNegotiationScreen> {
  final _msgCtrl = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'I need 500 meters. Can you offer ₹140/m?', 'isSeller': false, 'time': '10:00 AM'},
  ];

  void _sendMessage() {
    if (_msgCtrl.text.isNotEmpty) {
      setState(() {
        _messages.insert(0, {
          'text': _msgCtrl.text,
          'isSeller': true,
          'time': 'Just now'
        });
        _msgCtrl.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Negotiation', style: TextStyle(fontSize: 16)),
            Text('Fashion Hub - Premium Cotton', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.snackbar('Accepted', 'You have accepted the offer', backgroundColor: Colors.green, colorText: Colors.white);
              Get.back();
            },
            child: const Text('Accept', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[200],
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Current Target: ₹140/m', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Required: 500m', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg['isSeller'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: msg['isSeller'] ? Theme.of(context).colorScheme.primaryContainer : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(msg['text']),
                        const SizedBox(height: 4),
                        Text(msg['time'], style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, -2), blurRadius: 10),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgCtrl,
                    decoration: InputDecoration(
                      hintText: 'Type your counter offer...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
