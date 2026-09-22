import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_message_model.dart';
import '../models/product_model.dart';
import '../utils/dummy_data.dart';

class AiController extends GetxController {
  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<ProductModel?> contextProduct = Rx<ProductModel?>(null);
  
  final _uuid = const Uuid();

  @override
  void onInit() {
    super.onInit();
    // Check if a product was passed as an argument
    if (Get.arguments != null && Get.arguments is ProductModel) {
      contextProduct.value = Get.arguments as ProductModel;
    }
  }

  void sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 1. Add User Message
    messages.add(ChatMessageModel(
      id: _uuid.v4(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));

    // 2. Set Loading State
    isLoading.value = true;

    // 3. Simulate Network/AI Delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // 4. Generate Dummy AI Response
    String aiResponseText = _getDummyResponse(text);
    List<ProductModel>? recommendations;

    // If user asks for cheap or specific recommendations, attach dummy products
    if (text.toLowerCase().contains('under') || text.toLowerCase().contains('recommend')) {
      recommendations = [
        DummyData.products[0], // Cotton Fabric
        DummyData.products[2], // Printed Rayon
      ];
    }

    // 5. Add AI Message
    messages.add(ChatMessageModel(
      id: _uuid.v4(),
      text: aiResponseText,
      isUser: false,
      timestamp: DateTime.now(),
      recommendedProducts: recommendations,
    ));

    isLoading.value = false;
  }

  String _getDummyResponse(String query) {
    query = query.toLowerCase();
    
    if (query.contains('summer')) {
      return "Yes. Lightweight cotton or linen fabrics are highly recommended for summer clothing as they are highly breathable and absorb moisture well.";
    } else if (query.contains('moq')) {
      if (contextProduct.value != null) {
        return "The minimum order quantity (MOQ) for ${contextProduct.value!.name} is ${contextProduct.value!.moq} ${contextProduct.value!.unit}.";
      }
      return "The minimum order quantity depends on the specific product, but it generally ranges from 50 to 100 meters for wholesale orders.";
    } else if (query.contains('under')) {
      return "Here are some affordable products that fit your price range requirement.";
    } else if (query.contains('compare')) {
      return "Comparing these fabrics: Cotton is highly breathable but wrinkles easily, whereas Polyester is durable and wrinkle-resistant but less breathable.";
    } else if (query.contains('price')) {
      return "Pricing varies based on quantity. For bulk orders exceeding 500 meters, you can typically negotiate a 10-15% discount directly with the seller.";
    }
    
    return "That's a great question about textiles! Since I am currently operating in offline dummy mode, I don't have a specific answer for that. But later, I will be connected to a powerful AI to help you!";
  }

  void clearChat() {
    messages.clear();
  }
}
