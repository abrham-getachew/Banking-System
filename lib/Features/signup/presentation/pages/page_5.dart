import 'package:chronos/Features/signup/presentation/pages/page_6.dart';
import 'package:flutter/material.dart';

class NameAsInIDPage extends StatefulWidget {
  const NameAsInIDPage({super.key});

  @override
  State<NameAsInIDPage> createState() => _NameAsInIDPageState();
}

class _NameAsInIDPageState extends State<NameAsInIDPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool get _isFormValid =>
      _firstNameController.text.trim().isNotEmpty &&
          _lastNameController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_updateState);
    _lastNameController.addListener(_updateState);
  }

  void _updateState() => setState(() {});

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
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
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sh * 0.02),

              Text(
                "Name as in ID",
                style: TextStyle(
                  fontSize: sw * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: sh * 0.015),

              Text(
                "Enter your name exactly as it appears on your official documents.",
                style: TextStyle(
                  fontSize: sw * 0.045,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),

              SizedBox(height: sh * 0.04),

              Text(
                "First name",
                style: TextStyle(
                  fontSize: sw * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: sh * 0.01),

              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: "e.g. Daniel, not 'Dan'",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: sw * 0.04,
                    vertical: sh * 0.018,
                  ),
                ),
              ),

              SizedBox(height: sh * 0.025),

              Text(
                "Last name",
                style: TextStyle(
                  fontSize: sw * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: sh * 0.01),

              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: "Your surname",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: sw * 0.04,
                    vertical: sh * 0.018,
                  ),
                ),
              ),

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
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DateOfBirthPage()),
                    );
                    // Handle continue
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
}
