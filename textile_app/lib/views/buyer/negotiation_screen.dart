import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/quotation_controller.dart';

class NegotiationScreen extends StatefulWidget {
  const NegotiationScreen({super.key});

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  final QuotationController _controller = Get.find<QuotationController>();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late String _quoteId;

  @override
  void initState() {
    super.initState();
    _quoteId = Get.arguments as String;
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    // Check if message contains a price offer via basic regex parsing
    double? offeredPrice;
    final regex = RegExp(r'[₹\$]\s?(\d+(?:\.\d{1,2})?)');
    final match = regex.firstMatch(text);
    if (match != null) {
      offeredPrice = double.tryParse(match.group(1)!);
    }

    _controller.addNegotiationMessage(_quoteId, text, offeredPrice: offeredPrice);
    _textController.clear();
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Negotiation'),
      ),
      body: Obx(() {
        final quoteIndex = _controller.quotations.indexWhere((q) => q.id == _quoteId);
        if (quoteIndex == -1) return const SizedBox.shrink();
        final quote = _controller.quotations[quoteIndex];

        return Column(
          children: [
            // Current Price Header
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.orange.withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Current Seller Offer', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                      Text(
                        quote.sellerOfferedPrice != null ? '₹${quote.sellerOfferedPrice} / ${quote.product.unit}' : 'Awaiting Offer',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  if (quote.status != 'Accepted' && quote.status != 'Rejected' && quote.sellerOfferedPrice != null)
                    ElevatedButton(
                      onPressed: () {
                        _controller.acceptQuote(quote.id);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                      child: const Text('Accept Final'),
                    ),
                ],
              ),
            ),
            
            // Chat
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: quote.messages.length,
                itemBuilder: (context, index) {
                  final msg = quote.messages[index];
                  final isUser = msg.isBuyer;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isUser ? theme.colorScheme.primary : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20).copyWith(
                              bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(20),
                              bottomLeft: !isUser ? const Radius.circular(4) : const Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (msg.offeredPrice != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                            child: Text(
                              'Offered: ₹${msg.offeredPrice}',
                              style: TextStyle(color: isUser ? theme.colorScheme.primary : Colors.orange, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Input Area
            if (quote.status != 'Accepted' && quote.status != 'Rejected')
              Container(
                padding: const EdgeInsets.all(12).copyWith(bottom: 12 + MediaQuery.of(context).padding.bottom),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -2))],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'Type your message (e.g. Can you do ₹170?)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: theme.colorScheme.primary,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
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
}
