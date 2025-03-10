import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shoply/app_pages/welldone.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _selectedPaymentMethod;
  String? _deliveryAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDeliveryOption(
              icon: Icons.location_on,
              text: _deliveryAddress ?? 'Delivery Address',
              onTap: () => _showAddressForm(context),
            ),
            const SizedBox(height: 8),
            _buildDeliveryOption(
              icon: Icons.my_location,
              text: 'Deliver to your current location',
              onTap: () => _fetchCurrentLocation(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Payment Methods',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildPaymentOption(
              image: 'assets/visa.png',
              text: 'xxxx xxxx xxxx xxxx',
              value: 'visa',
            ),
            _buildPaymentOption(
              image: 'assets/mastercard.png',
              text: 'xxxx xxxx xxxx xxxx',
              value: 'mastercard',
            ),
            _buildPaymentOption(
              image: 'assets/applepay.png',
              text: 'Apple pay',
              value: 'applepay',
            ),
            _buildPaymentOption(
              image: 'assets/benefitpay.png',
              text: 'pay by Benefit',
              value: 'benefitpay',
            ),
            const SizedBox(height: 24),
            const Text(
              'Other',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildPaymentOption(
              image: 'assets/cash.png',
              text: 'Cash on Delivery',
              value: 'cash',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity, // Make the button take full width
              height: 50, // Increase the height for a bigger button
              child: ElevatedButton(
                onPressed: () {
                  // ✅ Navigate to WellDonePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WellDonePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20), // Increase padding for a bigger button
                  backgroundColor: const Color(0xFF1A4C64), // Updated color
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12), // Slightly larger corner radius for a modern look
                  ),
                ),
                child: const Text(
                  'Pay',
                  style: TextStyle(
                    fontSize: 18, // Slightly larger font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String image,
    required String text,
    required String value,
  }) {
    bool isSelected = _selectedPaymentMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF246793) : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(image, width: 40, height: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF246793))
            else
              const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Fetch location from the device
  Future<void> _fetchCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnackBar('Location services are disabled.');
        return;
      }

      // Check for permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnackBar('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showSnackBar('Location permissions are permanently denied.');
        return;
      }

      // Get current location
      Position position = await Geolocator.getCurrentPosition();

      // Convert coordinates to address
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _deliveryAddress =
              '${place.name}, ${place.street}, ${place.locality}, ${place.country}';
        });
      }
    } catch (e) {
      _showSnackBar('Failed to get location: $e');
    }
  }

  // Show address form
  void _showAddressForm(BuildContext context) {
    final TextEditingController buildingController = TextEditingController();
    final TextEditingController flatController = TextEditingController();
    final TextEditingController blockController = TextEditingController();
    final TextEditingController cityController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: buildingController,
                decoration:
                    const InputDecoration(labelText: 'Building Number')),
            TextField(
                controller: flatController,
                decoration: const InputDecoration(labelText: 'Flat')),
            TextField(
                controller: blockController,
                decoration: const InputDecoration(labelText: 'Block')),
            TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _deliveryAddress =
                      '${buildingController.text}, Flat ${flatController.text}, Block ${blockController.text}, ${cityController.text}';
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
