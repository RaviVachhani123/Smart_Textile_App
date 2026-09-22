import 'product_model.dart';

class NegotiationMessage {
  final String id;
  final String text;
  final bool isBuyer;
  final DateTime timestamp;
  final double? offeredPrice;

  NegotiationMessage({
    required this.id,
    required this.text,
    required this.isBuyer,
    required this.timestamp,
    this.offeredPrice,
  });
}

class QuotationModel {
  final String id;
  final ProductModel product;
  final int requiredQuantity;
  final double targetPrice;
  double? sellerOfferedPrice;
  final DateTime deliveryDate;
  String status; // Pending, Received, Accepted, Rejected, Negotiating
  final String initialMessage;
  final DateTime createdAt;
  final List<NegotiationMessage> messages;

  QuotationModel({
    required this.id,
    required this.product,
    required this.requiredQuantity,
    required this.targetPrice,
    this.sellerOfferedPrice,
    required this.deliveryDate,
    required this.status,
    required this.initialMessage,
    required this.createdAt,
    List<NegotiationMessage>? messages,
  }) : messages = messages ?? [];
}
