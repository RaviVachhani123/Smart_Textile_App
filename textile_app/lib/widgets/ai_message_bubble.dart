import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/chat_message_model.dart';
import 'product_card.dart';

class AiMessageBubble extends StatelessWidget {
  final ChatMessageModel message;

  const AiMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser) ...[
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  radius: 16,
                  child: Icon(Icons.smart_toy, size: 18, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isUser ? theme.colorScheme.primary : theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20).copyWith(
                      bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(20),
                      bottomLeft: !isUser ? const Radius.circular(4) : const Radius.circular(20),
                    ),
                    boxShadow: [
                      if (!isUser)
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: isUser ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              if (isUser) ...[
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 16,
                  child: const Icon(Icons.person, size: 18, color: Colors.grey),
                ),
              ],
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 4,
              left: isUser ? 0 : 40,
              right: isUser ? 40 : 0,
            ),
            child: Text(
              DateFormat('hh:mm a').format(message.timestamp),
              style: TextStyle(color: Colors.grey[500], fontSize: 10),
            ),
          ),
          // Product Recommendations
          if (message.recommendedProducts != null && message.recommendedProducts!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 40),
              child: SizedBox(
                height: 240, // Height for ProductCard in list/grid format
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: message.recommendedProducts!.length,
                  itemBuilder: (context, index) {
                    final product = message.recommendedProducts![index];
                    return ProductCard(product: product);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
