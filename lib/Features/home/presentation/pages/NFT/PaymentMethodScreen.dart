import 'package:flutter/material.dart';



class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Payment method'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select payment method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            RadioListTile(
              title: Text('Balance'),
              value: 'balance',
              groupValue: _selectedPaymentMethod,
              activeColor: Color(0xFF00C4B4),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value as String?;
                });
              },
              controlAffinity: ListTileControlAffinity.trailing,
            ),
            RadioListTile(
              title: Text('Card'),
              value: 'card',
              groupValue: _selectedPaymentMethod,
              activeColor: Color(0xFF00C4B4),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value as String?;
                });
              },
              controlAffinity: ListTileControlAffinity.trailing,
            ),
            RadioListTile(
              title: Text('Bank'),
              value: 'bank',
              groupValue: _selectedPaymentMethod,
              activeColor: Color(0xFF00C4B4),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value as String?;
                });
              },
              controlAffinity: ListTileControlAffinity.trailing,
            ),
            RadioListTile(
              title: Text('TickPay'),
              value: 'tickpay',
              groupValue: _selectedPaymentMethod,
              activeColor: Color(0xFF00C4B4),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value as String?;
                });
              },
              controlAffinity: ListTileControlAffinity.trailing,
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedPaymentMethod == null
                    ? null
                    : () {
                  // Handle continue action
                  print('Selected: $_selectedPaymentMethod');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFF00C4B4),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Continue'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFF5F7FA),
    );
  }
}