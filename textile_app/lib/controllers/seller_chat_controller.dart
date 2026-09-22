import 'package:get/get.dart';

class ChatMessage {
  final String text;
  final bool isSeller;
  final DateTime time;

  ChatMessage(this.text, this.isSeller, this.time);
}

class ChatThread {
  final String id;
  final String buyerName;
  final String productRef;
  final RxList<ChatMessage> messages;
  final RxInt unreadCount;

  ChatThread(this.id, this.buyerName, this.productRef, List<ChatMessage> initialMessages, int unread)
      : messages = initialMessages.obs,
        unreadCount = unread.obs;
}

class SellerChatController extends GetxController {
  final RxList<ChatThread> threads = <ChatThread>[].obs;

  @override
  void onInit() {
    super.onInit();
    threads.addAll([
      ChatThread(
        'c1', 
        'Zara Textiles', 
        'Silk Blend (Ref: P-102)', 
        [
          ChatMessage('Hi, can we negotiate the MOQ for the silk fabric?', false, DateTime.now().subtract(const Duration(minutes: 30))),
        ],
        1,
      ),
      ChatThread(
        'c2', 
        'Fashion Hub Pvt Ltd', 
        'Premium Cotton', 
        [
          ChatMessage('Is the shipping free for 1000 meters?', false, DateTime.now().subtract(const Duration(days: 1))),
          ChatMessage('Yes, for orders above 500m we provide free shipping.', true, DateTime.now().subtract(const Duration(hours: 20))),
          ChatMessage('Great, I will place the order today.', false, DateTime.now().subtract(const Duration(hours: 2))),
        ],
        0,
      ),
    ]);
  }

  void sendMessage(String threadId, String text) {
    final thread = threads.firstWhere((t) => t.id == threadId);
    thread.messages.add(ChatMessage(text, true, DateTime.now()));
  }

  void markAsRead(String threadId) {
    final thread = threads.firstWhere((t) => t.id == threadId);
    thread.unreadCount.value = 0;
  }
}
