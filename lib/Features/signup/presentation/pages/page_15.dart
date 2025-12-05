import 'package:flutter/material.dart';

import '../../../complete_signup/presentation/pages/page_1.dart';

class DocumentSelectPage extends StatefulWidget {
  @override
  _DocumentSelectPageState createState() => _DocumentSelectPageState();
}

class _DocumentSelectPageState extends State<DocumentSelectPage> {
  String _selected = 'passport';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              // Skip flow
            },
            child: Text('Not now', style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Select and upload',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),
            Text(
              'We need a valid document to confirm you reside in the United Kingdom and verify who you are. Data is processed securely.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            SizedBox(height: 32),
            _buildOption(
              key: 'passport',
              icon: Icons.book_online_outlined,
              label: 'Passport',
            ),

            SizedBox(height: 16),
            _buildOption(
              key: 'driving_license',
              icon: Icons.directions_car,
              label: 'Driving license',
            ),

            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _selected.isNotEmpty ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WhyUsechronsPage()),
                  ); // Continue action
                } : null,
                child: Text('Continue', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required String key,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selected == key;
    return GestureDetector(
      onTap: () => setState(() => _selected = key),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? Colors.blue : Colors.grey,
            ),

            SizedBox(width: 12),
            Icon(icon, color: Colors.blue, size: 28),

            SizedBox(width: 12),
            Text('🇬🇧', style: TextStyle(fontSize: 20)),
            SizedBox(width: 4),Text(

              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            Spacer(),

          ],
        ),
      ),
    );
  }
}
