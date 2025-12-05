import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Theme Colors and Constants ---
const Color _kDarkTextColor = Color(0xFF333333);
const Color _kLightTextColor = Color(0xFF666666);
const Color _kPrimaryButtonColor = Color(0xFF13A08D); // Bright blue submit button
const Color _kInputFillColor = Color(0xFFF0F0F0); // Light grey fill for input fields
const Color _kIconColor = Color(0xFF333333); // For close icon and bottom nav unselected
const Color _kLifeXSelectedColor = Color(0xFF333333); // Black/Dark color for the selected LifeX tab

class CreateCampaignScreen extends StatefulWidget {
  const CreateCampaignScreen({super.key});

  @override
  State<CreateCampaignScreen> createState() => _CreateCampaignScreenState();
}

class _CreateCampaignScreenState extends State<CreateCampaignScreen> {
  // --- State Variables ---
  int _selectedIndex = 3; // Initial selection for 'LifeX' tab (index 3, which often leads to this form)
  bool _isSubmitting = false; // State for button loading

  // Controllers for form fields
  final TextEditingController _photosController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _causeTypeController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  // --- Life Cycle Methods ---
  @override
  void dispose() {
    _photosController.dispose();
    _descriptionController.dispose();
    _targetController.dispose();
    _causeTypeController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic here
  }

  void _submitForm() {
    if (_isSubmitting) return;

    // Basic form validation check (demonstration only)
    if (_descriptionController.text.isEmpty || _targetController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all required fields.')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate an API call or submission process
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
        // In a real app: Navigator.pop(context); // Close the modal
        print('Campaign Submitted: Target ${_targetController.text}');
      }
    });
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. App Bar (Modal style)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: _kIconColor, size: 28),
          onPressed: () => Navigator.of(context).pop(), // Standard modal close action
        ),
        title: const Text(
          'Create Campaign',
          style: TextStyle(color: _kDarkTextColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      // 2. Body Content (Form)
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Upload Photos
            _buildFormSection(
              title: 'Upload photos',
              child: _buildInputField(
                controller: _photosController,
                hintText: 'Upload photos',
                keyboardType: TextInputType.text,
                minLines: 1,
                readOnly: true, // Typically read-only, triggers file picker
              ),
            ),
            const SizedBox(height: 30),

            // Add Description
            _buildFormSection(
              title: 'Add description',
              child: _buildInputField(
                controller: _descriptionController,
                hintText: '', // No specific hint text in the box in the image
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 10,
                contentPadding: const EdgeInsets.all(15), // Larger padding for text area
              ),
            ),
            const SizedBox(height: 30),

            // Fundraising Target
            _buildFormSection(
              title: 'Fundraising target',
              child: _buildInputField(
                controller: _targetController,
                hintText: 'Fundraising target',
                keyboardType: TextInputType.number,
                minLines: 1,
              ),
            ),
            const SizedBox(height: 30),

            // Choose Cause Type (Dropdown Placeholder)
            _buildFormSection(
              title: 'Choose cause type',
              child: _buildInputField(
                controller: _causeTypeController,
                hintText: '', // Placeholder for dropdown
                keyboardType: TextInputType.text,
                minLines: 1,
                readOnly: true, // Should be a dropdown/picker
              ),
            ),
            const SizedBox(height: 30),

            // Duration
            _buildFormSection(
              title: 'Duration',
              child: _buildInputField(
                controller: _durationController,
                hintText: 'Duration',
                keyboardType: TextInputType.datetime,
                minLines: 1,
                readOnly: true, // Should be a date/duration picker
              ),
            ),
            const SizedBox(height: 50),

            // Submit Button
            _buildSubmitButton(),
            const SizedBox(height: 20), // Space above nav bar
          ],
        ),
      ),
      // 3. Bottom Navigation Bar
      // Note: While this is a modal, the image shows the bottom nav bar, so we include it.
        bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Component Builders ---

  Widget _buildFormSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kDarkTextColor,
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    int minLines = 1,
    int? maxLines,
    bool readOnly = false,
    EdgeInsets contentPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  }) {
    // Determine the height of the container based on minLines for the visual clone
    double containerHeight = minLines == 1 ? 50 : (minLines * 30.0 + 20.0);

    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: _kInputFillColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines ?? minLines,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: _kLightTextColor.withOpacity(0.7)),
          contentPadding: contentPadding,
          border: InputBorder.none, // Remove default border
          isDense: true,
        ),
        style: const TextStyle(color: _kDarkTextColor),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submitForm, // Disable button if submitting
        style: ElevatedButton.styleFrom(
          backgroundColor: _kPrimaryButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isSubmitting
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : const Text(
          'Submit',
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