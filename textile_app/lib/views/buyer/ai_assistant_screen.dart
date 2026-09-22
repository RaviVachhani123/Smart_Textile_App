import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ai_controller.dart';
import '../../widgets/ai_message_bubble.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final AiController _aiController = Get.put(AiController());
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<String> _suggestions = [
    "Explain this fabric",
    "Is this good for summer?",
    "What is the MOQ?",
    "Compare these products",
    "Find fabric under ₹200",
    "Calculate price",
    "What can I make with this fabric?"
  ];

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _aiController.sendMessage(text);
    _textController.clear();
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Textile AI Assistant', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Your smart textile product assistant', style: TextStyle(fontSize: 12, color: Colors.grey[200])),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _aiController.clearChat,
            tooltip: 'Clear Chat',
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                // Context Card
          Obx(() {
            if (_aiController.contextProduct.value == null) return const SizedBox.shrink();
            final product = _aiController.contextProduct.value!;
            return Container(
              padding: const EdgeInsets.all(12),
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.inventory_2_outlined, color: theme.colorScheme.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Currently discussing:', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to details if not already there, but we likely are.
                      // Or just close to go back.
                      Get.back();
                    },
                    child: const Text('View Product', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            );
          }),
          
          // Chat Area
          Expanded(
            child: Obx(() {
              if (_aiController.messages.isEmpty) {
                return _buildWelcomeState(theme);
              }
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _aiController.messages.length + (_aiController.isLoading.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _aiController.messages.length) {
                    return _buildTypingIndicator(theme);
                  }
                  return AiMessageBubble(message: _aiController.messages[index]);
                },
              );
            }),
          ),
          
              // Input Area
              _buildInputArea(theme),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildWelcomeState(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primaryContainer,
            ),
            child: Icon(Icons.auto_awesome, size: 64, color: theme.colorScheme.primary),
          ),
          const SizedBox(height: 24),
          const Text(
            "Hello! I'm Textile AI.",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            "I can help you understand textile products, compare fabrics, check MOQ, estimate prices and find suitable products.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Quick Questions:", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _suggestions.map((suggestion) {
              return ActionChip(
                label: Text(suggestion),
                backgroundColor: theme.colorScheme.surface,
                side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                onPressed: () => _sendMessage(suggestion),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: theme.colorScheme.primaryContainer,
            radius: 16,
            child: Icon(Icons.smart_toy, size: 18, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20).copyWith(bottomLeft: const Radius.circular(4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dot(theme, 0),
                const SizedBox(width: 4),
                _dot(theme, 1),
                const SizedBox(width: 4),
                _dot(theme, 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(ThemeData theme, int index) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildInputArea(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12).copyWith(bottom: 12 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onSubmitted: _sendMessage,
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 24,
            backgroundColor: theme.colorScheme.primary,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => _sendMessage(_textController.text),
            ),
          ),
        ],
      ),
    );
  }
}
