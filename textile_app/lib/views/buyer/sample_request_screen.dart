import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/sample_controller.dart';
import '../../models/product_model.dart';

class SampleRequestScreen extends StatefulWidget {
  const SampleRequestScreen({super.key});

  @override
  State<SampleRequestScreen> createState() => _SampleRequestScreenState();
}

class _SampleRequestScreenState extends State<SampleRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final SampleController _controller = Get.find<SampleController>();
  late ProductModel _product;
  
  final _qtyController = TextEditingController(text: "1");
  final _colorController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null && Get.arguments is ProductModel) {
      _product = Get.arguments as ProductModel;
      if (_product.availableColors.isNotEmpty) {
        _colorController.text = _product.availableColors.first;
      }
    } else {
      Get.back();
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _controller.submitSampleRequest(
        product: _product,
        quantity: int.parse(_qtyController.text),
        color: _colorController.text.trim(),
        address: _addressController.text.trim(),
        notes: _notesController.text.trim(),
      );
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Sample'),
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
              Text('Request physical sample for:', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 8),
              Text(_product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const Divider(height: 32),
              
              TextFormField(
                controller: _qtyController,
                decoration: const InputDecoration(
                  labelText: 'Sample Quantity (meters/pieces)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  if (int.tryParse(val) == null) return 'Must be a number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _colorController,
                decoration: const InputDecoration(
                  labelText: 'Preferred Color/Variant',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Delivery Address',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Additional Notes',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 32),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Submit Sample Request', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
