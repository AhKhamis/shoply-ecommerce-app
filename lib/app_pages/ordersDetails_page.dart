import 'package:flutter/material.dart';
import 'package:shoply/model/model.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // Stepper Status based on Order Status
    int currentStep = _getStepFromStatus(order.status);

    // Calculate the total price
    double totalPrice = order.items
        .map((item) => item.price * item.quantity)
        .reduce((a, b) => a + b);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Order Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Stepper
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusStep('Pending', 0, currentStep),
                _buildStatusLine(currentStep > 0),
                _buildStatusStep('Approved', 1, currentStep),
                _buildStatusLine(currentStep > 1),
                _buildStatusStep('Delivered', 2, currentStep),
              ],
            ),
            const SizedBox(height: 24),

            // Summary Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Summary',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Order Items
                  ...order.items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item.name} (${item.quantity} Item${item.quantity > 1 ? 's' : ''})',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '${item.price.toStringAsFixed(2)} BD',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  const Divider(thickness: 0.5, color: Colors.grey),

                  // Subtotal & Service Fee
                  _buildSummaryRow('Subtotal', totalPrice),
                  _buildSummaryRow('Service fee', 2.00),
                  _buildSummaryRow(
                    'Total',
                    totalPrice + 2.00,
                    isBold: true,
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Payment Button
            ElevatedButton(
              onPressed: () {
                // Handle payment action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF246793).withOpacity(0.5),
                minimumSize: const Size(double.infinity, 48),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Payment',
                style: TextStyle(
                  color: Color(0xFF246793),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Order Again Button
            ElevatedButton(
              onPressed: () {
                // Handle order again action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF246793),
                minimumSize: const Size(double.infinity, 48),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Order Again',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Step Calculation from Status
  int _getStepFromStatus(String status) {
    switch (status) {
      case 'Pending':
        return 0;
      case 'Completed':
        return 2; // ✅ Treat completed as delivered
      default:
        return 2;
    }
  }

  // Status Step Widget
  Widget _buildStatusStep(String text, int step, int currentStep) {
    bool isActive = step <= currentStep;

    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF246793) : Colors.grey[300],
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? const Color(0xFF246793) : Colors.transparent,
              width: 2,
            ),
          ),
          child: isActive
              ? const Icon(Icons.check,
                  size: 16, color: Colors.white) // ✅ Visible check mark
              : null,
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.black : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // Status Line Connector
  Widget _buildStatusLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? const Color(0xFF246793) : Colors.grey[300],
      ),
    );
  }

  // Summary Row Widget
  Widget _buildSummaryRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Text(
            '${value.toStringAsFixed(2)} BD',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
