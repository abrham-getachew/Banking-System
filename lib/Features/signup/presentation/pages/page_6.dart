import 'package:chronos/Features/signup/presentation/pages/page_7.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
 // Add intl in pubspec.yaml for date formatting

class DateOfBirthPage extends StatefulWidget {
  const DateOfBirthPage({super.key});

  @override
  State<DateOfBirthPage> createState() => _DateOfBirthPageState();
}

class _DateOfBirthPageState extends State<DateOfBirthPage> {
  final TextEditingController _dobController = TextEditingController();

  bool get _isFormValid {
    final text = _dobController.text.trim();
    final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!regex.hasMatch(text)) return false;

    try {
      final parts = text.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final date = DateTime(year, month, day);

      final now = DateTime.now();
      return date.year == year &&
          date.month == month &&
          date.day == day &&
          date.isBefore(now);
    } catch (_) {
      return false;
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day), // default 18 years old
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null) {
      final formatted = DateFormat('dd/MM/yyyy').format(picked);
      _dobController.text = formatted;
    }
  }

  @override
  void initState() {
    super.initState();
    _dobController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _dobController.dispose();
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

              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Date of birth",
                      style: TextStyle(
                        fontSize: sw * 0.07,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.blue),
                    onPressed: _pickDate,
                  ),
                ],
              ),

              SizedBox(height: sh * 0.04),

              Text(
                "Date",
                style: TextStyle(
                  fontSize: sw * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: sh * 0.01),

              TextField(
                controller: _dobController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "DD/MM/YYYY",
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
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month, color: Colors.grey),
                    onPressed: _pickDate,
                  ),
                ),
              ),

              SizedBox(height: sh * 0.01),

              Text(
                "Day, month, year",
                style: TextStyle(
                  fontSize: sw * 0.035,
                  color: Colors.grey[600],
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
                      MaterialPageRoute(
                          builder: (_) => const PostcodePage()),
                    );
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
