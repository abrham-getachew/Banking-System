import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle form input and toggle switch) ---
class TripFormScreen extends StatefulWidget {
  const TripFormScreen({super.key});

  @override
  State<TripFormScreen> createState() => _TripFormScreenState();
}

class _TripFormScreenState extends State<TripFormScreen> {
  // State for the bottom navigation bar

  // State for the form's toggle switch
  bool _includeGroupPackages = false;

  // Form Controllers (Attention to detail for a production-ready form)
  final TextEditingController _datesController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _faithController = TextEditingController();
  final TextEditingController _companionsController = TextEditingController();

  // Custom colors derived from the image
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _blueAccentColor = Color(0xFF13A08D); // Blue color for the submit button
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _inputFieldColor = Color(0xFFF0F0F0); // Light gray for input fields

  @override
  void dispose() {
    _datesController.dispose();
    _budgetController.dispose();
    _faithController.dispose();
    _companionsController.dispose();
    super.dispose();
  }

  // --- Reusable Widget for a Form Input Field ---
  Widget _buildInputField({
    required String labelText,
    required TextEditingController controller,
    bool isDate = false,
  }) {
    // The image shows the label text almost like a placeholder but slightly elevated
    // We use a Stack/TextField combination to achieve this look.
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 60, // Fixed height to match the image
        decoration: BoxDecoration(
          color: _inputFieldColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            // The Label Text (Placeholder Style)
            Positioned(
              top: 10,
              left: 15,
              child: Text(
                labelText,
                style: const TextStyle(
                  color: _secondaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // The actual input area (can be focused/clicked)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                child: TextField(
                  controller: controller,
                  keyboardType: isDate ? TextInputType.datetime : TextInputType.text,
                  style: const TextStyle(
                    color: _primaryTextColor,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Hide default underline
                    contentPadding: EdgeInsets.zero,
                  ),
                  readOnly: isDate, // If it's a date field, make it read-only for a date picker
                  onTap: isDate
                      ? () {
                    // Simulate date picker opening
                    print('Date picker opened');
                  }
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget for the fixed bottom navigation bar ---


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: _scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: _primaryTextColor,
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Trip Form',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    // --- Input Fields ---
                    _buildInputField(
                      labelText: 'Preferred Dates',
                      controller: _datesController,
                      isDate: true,
                    ),
                    _buildInputField(
                      labelText: 'Budget',
                      controller: _budgetController,
                    ),
                    _buildInputField(
                      labelText: 'Faith',
                      controller: _faithController,
                    ),
                    _buildInputField(
                      labelText: 'Companions',
                      controller: _companionsController,
                    ),

                    const SizedBox(height: 10),

                    // --- Toggle Switch (Include group packages) ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Include group packages',
                          style: TextStyle(
                            color: _primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Switch(
                          value: _includeGroupPackages,
                          onChanged: (bool newValue) {
                            setState(() {
                              _includeGroupPackages = newValue;
                            });
                          },
                          activeColor: Colors.white,
                          activeTrackColor: _blueAccentColor, // Blue track when active
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey.shade300,
                          // The switch in the image appears slightly larger than default, but we use the standard Flutter switch
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // --- Submit Button (Fixed at Bottom) ---
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('Submit pressed!');
                    // Form data:
                    // Dates: ${_datesController.text}
                    // Budget: ${_budgetController.text}
                    // Packages: $_includeGroupPackages
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blueAccentColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Slightly rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}