import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Theme Colors and Constants ---
const Color _kDarkTextColor = Color(0xFF333333);
const Color _kLightTextColor = Color(0xFF666666);
const Color _kPrimaryButtonColor = Color(0xFF3366FF); // Bright blue checkout button
const Color _kItemImageColor = Color(0xFF13A08D); // Teal/green color for the item placeholder
const Color _kTotalColor = Color(0xFF000000); // Black for the total price
const Color _kIconColor = Color(0xFF333333); // For bottom nav icons
const Color _kLifeXSelectedColor = Color(0xFF333333); // Black/Dark color for the selected LifeX tab

class SpiritualCartScreen extends StatefulWidget {
  const SpiritualCartScreen({super.key});

  @override
  State<SpiritualCartScreen> createState() => _SpiritualCartScreenState();
}

class _SpiritualCartScreenState extends State<SpiritualCartScreen> {
  // --- State Variables ---
  int _selectedIndex = 3; // Initial selection for 'LifeX' tab (index 3)
  bool _isCheckingOut = false; // State for button loading

  // State to hold and manage shipping address
  String _shippingAddress = '123 Serenity Lane, Harmony, CA 90210';

  // Order Details (Example State)
  final double _subtotal = 29.99;
  final double _shippingCost = 0.00; // Free shipping

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic here
  }

  void _startCheckout() {
    if (_isCheckingOut) return;

    setState(() {
      _isCheckingOut = true;
    });

    // Simulate a secure checkout process
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isCheckingOut = false;
        });
        // In a real app: Navigate to payment screen or confirmation
        print('Checkout initiated for \$${(_subtotal + _shippingCost).toStringAsFixed(2)}');
        }
        });
  }

  void _editShippingAddress() {
    // In a real app, this would open a modal to change the address
    print('Editing shipping address...');
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    double total = _subtotal + _shippingCost;

    return Scaffold(
      backgroundColor: Colors.white,
      // 1. App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: _kDarkTextColor),
        title: const Text(
          'Cart',
          style: TextStyle(color: _kDarkTextColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      // 2. Body Content
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Order Summary Section
                  _buildSectionTitle('Order Summary'),
                  const SizedBox(height: 15),
                  _buildItemSummary(),
                  const SizedBox(height: 25),
                  _buildPriceBreakdown(_subtotal, _shippingCost, total),
                  const Divider(height: 40, color: Color(0xFFF0F0F0)),

                  // Shipping Details Section
                  _buildSectionTitle('Shipping Details'),
                  const SizedBox(height: 15),
                  _buildShippingMethod(),
                  const SizedBox(height: 25),
                  _buildShippingAddress(address: _shippingAddress),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Checkout Button (Fixed at the bottom above the Nav Bar)
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
            child: _buildCheckoutButton(),
          ),

          // 3. Bottom Navigation Bar

        ],
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Component Builders ---

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: _kDarkTextColor,
      ),
    );
  }

  Widget _buildItemSummary() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Item Image Placeholder
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: _kItemImageColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kItemImageColor.withOpacity(0.5)),
          ),
          child: Icon(Icons.book, color: _kItemImageColor, size: 30),
        ),
        const SizedBox(width: 15),
        // Item Details
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spiritual Wellness Guide',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _kDarkTextColor,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '1 item',
              style: TextStyle(
                fontSize: 14,
                color: _kLightTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceBreakdown(double subtotal, double shipping, double total) {
    return Column(
      children: [
        _buildPriceRow(label: 'Subtotal', amount: subtotal.toStringAsFixed(2), isTotal: false),
        const SizedBox(height: 10),
        _buildPriceRow(label: 'Shipping', amount: shipping == 0.0 ? 'Free' : shipping.toStringAsFixed(2), isTotal: false),
        const SizedBox(height: 15),
        _buildPriceRow(label: 'Total', amount: total.toStringAsFixed(2), isTotal: true),
      ],
    );
  }

  Widget _buildPriceRow({required String label, required String amount, required bool isTotal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? _kTotalColor : _kLightTextColor,
          ),
        ),
        Text(
          amount == 'Free' ? amount : '\$$amount',
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? _kTotalColor : _kDarkTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildShippingMethod() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _kDarkTextColor,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Standard',
              style: TextStyle(
                fontSize: 16,
                color: _kLightTextColor,
              ),
            ),
          ],
        ),
        Text(
          _shippingCost == 0.0 ? 'Free' : '\$${_shippingCost.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _kDarkTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildShippingAddress({required String address}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Shipping Address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _kDarkTextColor,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                address,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  color: _kLightTextColor,
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: _editShippingAddress,
                child: const Icon(Icons.edit_outlined, color: _kLightTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isCheckingOut ? null : _startCheckout,
        style: ElevatedButton.styleFrom(
          backgroundColor: _kPrimaryButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isCheckingOut
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


}