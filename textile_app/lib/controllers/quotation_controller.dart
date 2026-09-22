import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/quotation_model.dart';
import '../models/product_model.dart';

class QuotationController extends GetxController {
  final RxList<QuotationModel> quotations = <QuotationModel>[].obs;
  final _uuid = const Uuid();

  void submitQuotationRequest({
    required ProductModel product,
    required int quantity,
    required double targetPrice,
    required DateTime deliveryDate,
    required String message,
  }) {
    final newQuote = QuotationModel(
      id: _uuid.v4(),
      product: product,
      requiredQuantity: quantity,
      targetPrice: targetPrice,
      deliveryDate: deliveryDate,
      status: 'Pending',
      initialMessage: message,
      createdAt: DateTime.now(),
    );
    quotations.insert(0, newQuote);
    Get.snackbar('Success', 'Quotation requested successfully');
  }

  void addNegotiationMessage(String quotationId, String text, {double? offeredPrice, bool isBuyer = true}) {
    final index = quotations.indexWhere((q) => q.id == quotationId);
    if (index != -1) {
      final quote = quotations[index];
      
      final msg = NegotiationMessage(
        id: _uuid.v4(),
        text: text,
        isBuyer: isBuyer,
        timestamp: DateTime.now(),
        offeredPrice: offeredPrice,
      );
      
      quote.messages.add(msg);
      
      if (offeredPrice != null && !isBuyer) {
        quote.sellerOfferedPrice = offeredPrice;
      }
      
      if (quote.status == 'Received' || quote.status == 'Pending') {
        quote.status = 'Negotiating';
      }
      
      quotations.refresh();
      
      // Simulate seller reply if buyer sends a message
      if (isBuyer) {
        _simulateSellerReply(quotationId, text);
      }
    }
  }

  void _simulateSellerReply(String quotationId, String buyerText) {
    Future.delayed(const Duration(seconds: 2), () {
      final index = quotations.indexWhere((q) => q.id == quotationId);
      if (index != -1) {
        final quote = quotations[index];
        if (quote.status == 'Accepted' || quote.status == 'Rejected') return;

        double currentOffer = quote.sellerOfferedPrice ?? (quote.product.price * 0.95);
        
        // Simple logic: if buyer mentions a price or asks, we just counter offer or accept.
        // If buyer target is within 5% of seller offer, accept.
        double buyerLatestOffer = quote.targetPrice;
        for (var m in quote.messages.reversed) {
          if (m.isBuyer && m.offeredPrice != null) {
            buyerLatestOffer = m.offeredPrice!;
            break;
          }
        }
        
        if (buyerLatestOffer >= currentOffer * 0.95) {
          addNegotiationMessage(quotationId, "We can agree to your price.", isBuyer: false, offeredPrice: buyerLatestOffer);
          quote.status = 'Accepted';
        } else {
          double newOffer = currentOffer * 0.98; // reduce price by 2%
          addNegotiationMessage(quotationId, "The best we can do is ₹${newOffer.toStringAsFixed(2)}", isBuyer: false, offeredPrice: newOffer);
        }
        quotations.refresh();
      }
    });
  }

  void acceptQuote(String quotationId) {
    final index = quotations.indexWhere((q) => q.id == quotationId);
    if (index != -1) {
      quotations[index].status = 'Accepted';
      quotations.refresh();
      Get.snackbar('Accepted', 'You have accepted the quotation');
    }
  }

  void rejectQuote(String quotationId) {
    final index = quotations.indexWhere((q) => q.id == quotationId);
    if (index != -1) {
      quotations[index].status = 'Rejected';
      quotations.refresh();
      Get.snackbar('Rejected', 'You have rejected the quotation');
    }
  }
}
