import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../../controllers/seller_products_controller.dart';
import 'package:uuid/uuid.dart';

class SellerAddProductScreen extends StatefulWidget {
  const SellerAddProductScreen({super.key});

  @override
  State<SellerAddProductScreen> createState() => _SellerAddProductScreenState();
}

class _SellerAddProductScreenState extends State<SellerAddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  ProductModel? _existingProduct;

  final _nameCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();
  final _fabricCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _wholesaleCtrl = TextEditingController();
  final _moqCtrl = TextEditingController();
  final _stockCtrl = TextEditingController();
  final _gsmCtrl = TextEditingController();
  final _widthCtrl = TextEditingController();
  final _materialCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null && Get.arguments is ProductModel) {
      _existingProduct = Get.arguments as ProductModel;
      _nameCtrl.text = _existingProduct!.name;
      _categoryCtrl.text = _existingProduct!.category;
      _descCtrl.text = _existingProduct!.description;
      _priceCtrl.text = _existingProduct!.price.toString();
      _moqCtrl.text = _existingProduct!.moq.toString();
      _gsmCtrl.text = _existingProduct!.gsm.toString();
      _materialCtrl.text = _existingProduct!.materialComposition;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _categoryCtrl.dispose();
    _fabricCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _wholesaleCtrl.dispose();
    _moqCtrl.dispose();
    _stockCtrl.dispose();
    _gsmCtrl.dispose();
    _widthCtrl.dispose();
    _materialCtrl.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final controller = Get.find<SellerProductsController>();
      
      final product = ProductModel(
        id: _existingProduct?.id ?? const Uuid().v4(),
        name: _nameCtrl.text,
        category: _categoryCtrl.text,
        description: _descCtrl.text,
        price: double.tryParse(_priceCtrl.text) ?? 0.0,
        unit: 'meter', // Hardcoded for simplicity
        imageUrl: '',
        seller: 'Surat Textiles Pvt Ltd',
        rating: _existingProduct?.rating ?? 0.0,
        moq: int.tryParse(_moqCtrl.text) ?? 50,
        inStock: (int.tryParse(_stockCtrl.text) ?? 0) > 0,
        gsm: int.tryParse(_gsmCtrl.text) ?? 0,
        materialComposition: _materialCtrl.text,
        availableColors: _existingProduct?.availableColors ?? ['White'],
      );

      if (_existingProduct != null) {
        controller.editProduct(product.id, product);
      } else {
        controller.addProduct(product);
      }
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_existingProduct != null ? 'Edit Product' : 'Add New Product'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
          children: [
            // Image Upload Placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Tap to upload product images', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            const Text('Basic Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Product Name', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: TextFormField(controller: _categoryCtrl, decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()))),
                const SizedBox(width: 16),
                Expanded(child: TextFormField(controller: _fabricCtrl, decoration: const InputDecoration(labelText: 'Fabric Type', border: OutlineInputBorder()))),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              maxLines: 3,
            ),
            
            const SizedBox(height: 24),
            const Text('Pricing & Inventory', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextFormField(controller: _priceCtrl, decoration: const InputDecoration(labelText: 'Price (₹)', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                const SizedBox(width: 16),
                Expanded(child: TextFormField(controller: _wholesaleCtrl, decoration: const InputDecoration(labelText: 'Wholesale Price (₹)', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: TextFormField(controller: _moqCtrl, decoration: const InputDecoration(labelText: 'MOQ', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                const SizedBox(width: 16),
                Expanded(child: TextFormField(controller: _stockCtrl, decoration: const InputDecoration(labelText: 'Available Stock', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              ],
            ),

            const SizedBox(height: 24),
            const Text('Technical Specifications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextFormField(controller: _gsmCtrl, decoration: const InputDecoration(labelText: 'GSM', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                const SizedBox(width: 16),
                Expanded(child: TextFormField(controller: _widthCtrl, decoration: const InputDecoration(labelText: 'Width', border: OutlineInputBorder()))),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _materialCtrl,
              decoration: const InputDecoration(labelText: 'Material Composition', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 32),
            
            ElevatedButton(
              onPressed: _saveProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Save Product'),
            ),
            const SizedBox(height: 32),
          ],
        ),
            ),
          ),
        ),
      ),
    );
  }
}
