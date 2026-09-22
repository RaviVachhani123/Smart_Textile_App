import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/quotation_controller.dart';
import '../../models/product_model.dart';

class QuotationRequestScreen extends StatefulWidget {
  const QuotationRequestScreen({super.key});

  @override
  State<QuotationRequestScreen> createState() => _QuotationRequestScreenState();
}

class _QuotationRequestScreenState extends State<QuotationRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final QuotationController _controller = Get.find<QuotationController>();
  late ProductModel _product;
  
  final _qtyController = TextEditingController();
  final _targetPriceController = TextEditingController();
  final _messageController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null && Get.arguments is ProductModel) {
      _product = Get.arguments as ProductModel;
      _qtyController.text = _product.moq.toString();
      _targetPriceController.text = _product.price.toString();
    } else {
      Get.back();
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      _controller.submitQuotationRequest(
        product: _product,
        quantity: int.parse(_qtyController.text),
        targetPrice: double.parse(_targetPriceController.text),
        deliveryDate: _selectedDate!,
        message: _messageController.text.trim(),
      );
      Get.back(); // Go back to product details
    } else if (_selectedDate == null) {
      Get.snackbar('Error', 'Please select a delivery date');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Quotation'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Form(
                key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Info snippet
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: const Icon(Icons.inventory_2_outlined),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(_product.seller, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        Text('Listed Price: ₹${_product.price} / ${_product.unit}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 32),
              
              TextFormField(
                controller: _qtyController,
                decoration: const InputDecoration(
                  labelText: 'Required Quantity',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  if (int.tryParse(val) == null) return 'Must be a number';
                  if (int.parse(val) < _product.moq) return 'Minimum is ${_product.moq}';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _targetPriceController,
                decoration: const InputDecoration(
                  labelText: 'Target Price (₹ per unit)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.currency_rupee),
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  if (double.tryParse(val) == null) return 'Must be a number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              ListTile(
                title: Text(_selectedDate == null ? 'Select Delivery Date' : 'Delivery: ${_selectedDate!.toLocal().toString().split(' ')[0]}'),
                leading: const Icon(Icons.calendar_today),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(4),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 7)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Message to Seller',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Please provide requirements';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Submit Quotation Request', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }
}
