import 'package:flutter/material.dart';

class AdminCreateShopPage extends StatefulWidget {
  const AdminCreateShopPage({super.key});

  @override
  State<AdminCreateShopPage> createState() => _AdminCreateShopPageState();
}

class _AdminCreateShopPageState extends State<AdminCreateShopPage> {
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FD),
      appBar: AppBar(
        title: const Text(
          'Create New Shop',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ✅ Shop Logo Picker (Design Only)
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[300],
              ),
              child: const Icon(Icons.add_a_photo,
                  size: 40, color: Colors.white70),
            ),

            const SizedBox(height: 24),

            // ✅ Shop Name
            TextField(
              focusNode: _nameFocus,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.storefront_outlined,
                  color: _nameFocus.hasFocus ? Colors.black : Colors.grey,
                ),
                hintText: 'Shop Name',
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ✅ Shop Description
            TextField(
              focusNode: _descFocus,
              maxLines: 3,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.description_outlined,
                  color: _descFocus.hasFocus ? Colors.black : Colors.grey,
                ),
                hintText: 'Shop Description',
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ✅ Background Image Picker (Design Only)
            Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[300],
              ),
              child: const Center(
                child:
                    Icon(Icons.image_outlined, size: 40, color: Colors.white70),
              ),
            ),

            const SizedBox(height: 32),

            // ✅ Submit Button (Design Only)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A4C64),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Create Shop',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
