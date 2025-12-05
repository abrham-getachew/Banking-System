import 'package:chronos/Features/signup/presentation/pages/page_10.dart';
import 'package:flutter/material.dart';

class PageNine extends StatefulWidget {
  const PageNine({super.key});

  @override
  State<PageNine> createState() => _PageNineState();
}

class _PageNineState extends State<PageNine> {
  final TextEditingController _emailController = TextEditingController();
  bool _keepUpdated = true;

  bool get _isEmailValid {
    final email = _emailController.text.trim();
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
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
              SizedBox(height: sh * 0.015),

              Text(
                "Email",
                style: TextStyle(
                  fontSize: sw * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: sh * 0.04),

              Text(
                "Email address",
                style: TextStyle(
                  fontSize: sw * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: sh * 0.01),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email address",
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

              SizedBox(height: sh * 0.02),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _keepUpdated,
                    onChanged: (val) {
                      setState(() {
                        _keepUpdated = val ?? false;
                      });
                    },
                    activeColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Keep me up to date about personalised Revolut offers, products and services.",
                      style: TextStyle(
                        fontSize: sw * 0.038,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: sh * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _isEmailValid ? Colors.blue : Colors.grey[300],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _isEmailValid
                      ? () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PageTen()),
                      );

                    // Handle next step
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
