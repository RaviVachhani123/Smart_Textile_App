import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/seller_chat_controller.dart';
import '../../../app/routes/app_routes.dart';

class SellerMessagesTab extends StatelessWidget {
  const SellerMessagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerChatController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Obx(() {
        if (controller.threads.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey[300]),
                const SizedBox(height: 16),
                const Text('No messages yet'),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.threads.length,
          itemBuilder: (context, index) {
            final thread = controller.threads[index];
            return Obx(() {
              final lastMessage = thread.messages.isNotEmpty ? thread.messages.last : null;
              final hasUnread = thread.unreadCount.value > 0;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Text(thread.buyerName[0]),
                ),
                title: Text(
                  thread.buyerName,
                  style: TextStyle(fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(thread.productRef, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary)),
                    if (lastMessage != null)
                      Text(
                        lastMessage.text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal),
                      ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (lastMessage != null)
                      Text(
                        '${lastMessage.time.hour}:${lastMessage.time.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    if (hasUnread)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        child: Text(
                          thread.unreadCount.value.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  controller.markAsRead(thread.id);
                  Get.toNamed(AppRoutes.sellerChat, arguments: thread);
                },
              );
            });
          },
        );
      }),
    );
  }
}
