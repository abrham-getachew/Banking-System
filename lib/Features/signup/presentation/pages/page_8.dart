import 'package:chronos/Features/signup/presentation/pages/page_9.dart';
import 'package:flutter/material.dart';

class PageEight extends StatefulWidget {
  final String? selectedAddress; // passed from Page 7
  const PageEight({super.key, this.selectedAddress});

  @override
  State<PageEight> createState() => _PageEightState();
}

class _PageEightState extends State<PageEight> {
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool get _isFormValid =>
      _postcodeController.text.trim().isNotEmpty &&
          _addressLine1Controller.text.trim().isNotEmpty &&
          _cityController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    // Pre-fill from Page 7 if available
    if (widget.selectedAddress != null) {
      final parts = widget.selectedAddress!.split(',');
      if (parts.isNotEmpty) _addressLine1Controller.text = parts[0].trim();
      if (parts.length > 1) _cityController.text = parts[1].trim();
    }
    _postcodeController.addListener(() => setState(() {}));
    _addressLine1Controller.addListener(() => setState(() {}));
    _cityController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _postcodeController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Home address",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sh * 0.015),
              Text(
                "By law, we need your home address to open your account.",
                style: TextStyle(fontSize: sw * 0.04, color: Colors.grey[700]),
              ),
              SizedBox(height: sh * 0.03),

              _buildField("Postcode", _postcodeController),
              SizedBox(height: sh * 0.02),

              _buildField("Address line 1", _addressLine1Controller),
              SizedBox(height: sh * 0.02),

              _buildField("Address line 2 (Optional)", _addressLine2Controller),
              SizedBox(height: sh * 0.02),

              _buildField("City", _cityController),
              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: sh * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _isFormValid ? Colors.blue : Colors.grey[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _isFormValid
                      ? ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PageNine()),
                      );
                    // Handle final submission
                  }
                      : null,
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: sw * 0.05),
                  ),
                ),
              ),
              SizedBox(height: sh * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
