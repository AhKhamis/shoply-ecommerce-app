import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ShopCreateProductPage extends StatefulWidget {
  const ShopCreateProductPage({super.key});

  @override
  State<ShopCreateProductPage> createState() => _ShopCreateProductPageState();
}

class _ShopCreateProductPageState extends State<ShopCreateProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController longDescController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FD),
      appBar: AppBar(
        title: const Text('Create New Product'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  image: _imageFile != null
                      ? DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _imageFile == null
                    ? const Center(
                        child: Icon(Icons.add_a_photo,
                            size: 40, color: Colors.grey))
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
                controller: nameController,
                hint: 'Product Name',
                icon: Icons.label),
            const SizedBox(height: 16),
            _buildTextField(
                controller: shortDescController,
                hint: 'Short Description',
                icon: Icons.info_outline),
            const SizedBox(height: 16),
            _buildTextField(
                controller: longDescController,
                hint: 'Long Description',
                icon: Icons.description),
            const SizedBox(height: 16),
            _buildTextField(
                controller: quantityController,
                hint: 'Quantity',
                icon: Icons.format_list_numbered,
                inputType: TextInputType.number),
            const SizedBox(height: 16),
            _buildTextField(
                controller: priceController,
                hint: 'Price (BD)',
                icon: Icons.attach_money,
                inputType: TextInputType.number),
            const SizedBox(height: 16),
            _buildTextField(
                controller: categoryController,
                hint: 'Category',
                icon: Icons.category),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A4C64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
