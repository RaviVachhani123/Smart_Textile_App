import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/sample_request_model.dart';
import '../models/product_model.dart';

class SampleController extends GetxController {
  final RxList<SampleRequestModel> sampleRequests = <SampleRequestModel>[].obs;
  final _uuid = const Uuid();

  void submitSampleRequest({
    required ProductModel product,
    required int quantity,
    required String color,
    required String address,
    required String notes,
  }) {
    final newRequest = SampleRequestModel(
      id: _uuid.v4(),
      product: product,
      quantity: quantity,
      color: color,
      address: address,
      notes: notes,
      status: 'Requested',
      createdAt: DateTime.now(),
    );
    
    sampleRequests.insert(0, newRequest);
    Get.snackbar('Success', 'Sample requested successfully');
    
    // Simulate seller accepting and processing
    _simulateStatusUpdates(newRequest.id);
  }

  void _simulateStatusUpdates(String requestId) {
    // 5 seconds -> Accepted
    Future.delayed(const Duration(seconds: 5), () {
      _updateStatus(requestId, 'Accepted');
    });
    
    // 15 seconds -> Processing
    Future.delayed(const Duration(seconds: 15), () {
      _updateStatus(requestId, 'Processing');
    });
  }
  
  void _updateStatus(String id, String newStatus) {
    final index = sampleRequests.indexWhere((r) => r.id == id);
    if (index != -1) {
      sampleRequests[index].status = newStatus;
      sampleRequests.refresh();
    }
  }
}
