import 'product_model.dart';

class SampleRequestModel {
  final String id;
  final ProductModel product;
  final int quantity;
  final String color;
  final String address;
  final String notes;
  String status; // Requested, Accepted, Processing, Shipped, Delivered, Rejected
  final DateTime createdAt;

  SampleRequestModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.color,
    required this.address,
    required this.notes,
    required this.status,
    required this.createdAt,
  });
}
