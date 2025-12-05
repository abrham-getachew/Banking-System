import 'package:flutter/material.dart';

import '../../nav_page.dart';

class TaxFilingAssistanceScreen extends StatefulWidget {
  @override
  _TaxFilingAssistanceScreenState createState() =>
      _TaxFilingAssistanceScreenState();
}

class _TaxFilingAssistanceScreenState
    extends State<TaxFilingAssistanceScreen> {
  bool _w2Uploaded = true;
  bool _1099Pending = false;
  bool _documentsReviewed = false;

  void _toggleChecklistItem(String item, bool value) {
    setState(() {
      if (item == 'w2') _w2Uploaded = value;
      else if (item == '1099') _1099Pending = value;
      else if (item == 'documents') _documentsReviewed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    int completedItems = (_w2Uploaded ? 1 : 0) +
        (_1099Pending ? 1 : 0) +
        (_documentsReviewed ? 1 : 0);
    double progress = 3 > 0 ? completedItems / 3 : 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[100],
        // Use a single ListView for the entire scrollable body
        child: ListView(
          // Set padding to zero to allow the image to be full-width
          padding: EdgeInsets.zero,
          children: [
            // 1. Full-width image container (now part of the scroll)
            Container(
              height: 400,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown[200]!, Colors.brown[400]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/financial image6.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 2. Wrap the rest of the content in a Padding widget
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tax Checklist',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                  SizedBox(height: 16),
                  CheckboxListTile(
                    title: Text('W-2 uploaded'),
                    value: _w2Uploaded,
                    onChanged: (value) =>
                        _toggleChecklistItem('w2', value ?? false),
                    activeColor: Colors.teal,
                    checkColor: Colors.white,
                  ),
                  CheckboxListTile(
                    title: Text('1099 pending'),
                    value: _1099Pending,
                    onChanged: (value) =>
                        _toggleChecklistItem('1099', value ?? false),
                    activeColor: Colors.teal,
                    checkColor: Colors.white,
                  ),
                  CheckboxListTile(
                    title: Text('Tax documents reviewed'),
                    value: _documentsReviewed,
                    onChanged: (value) =>
                        _toggleChecklistItem('documents', value ?? false),
                    activeColor: Colors.teal,
                    checkColor: Colors.white,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(fontSize: 16, color: Colors.teal),
                      ),
                      Text(
                        '$completedItems/3',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.teal[100],
                    color: Colors.teal,
                  ),
                  SizedBox(height: 24),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.brown[200]!, Colors.brown[400]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}