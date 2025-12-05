import 'package:flutter/material.dart';

import '../../nav_page.dart';

class AutomaticSavingPlansScreen extends StatefulWidget {
  @override
  _AutomaticSavingPlansScreenState createState() =>
      _AutomaticSavingPlansScreenState();
}

class _AutomaticSavingPlansScreenState
    extends State<AutomaticSavingPlansScreen> {
  bool _rule1Enabled = true;
  bool _rule2Enabled = false;
  bool _rule3Enabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Make back button functional
          },
        ),
        title: Text(
          'Automatic Saving Plans',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Fixed Image Container ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage('assets/images/financial image2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Smart Rules',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800]),
              ),
            ),
            // --- Smart Rules Switches ---
            _buildRuleSwitch(
              title: 'Rule 1: Save \$5 when you spend \$50',
              value: _rule1Enabled,
              onChanged: (value) {
                setState(() {
                  _rule1Enabled = value;
                });
              },
            ),
            _buildRuleSwitch(
              title: 'Rule 2: Save \$10 when you spend \$100',
              value: _rule2Enabled,
              onChanged: (value) {
                setState(() {
                  _rule2Enabled = value;
                });
              },
            ),
            _buildRuleSwitch(
              title: 'Rule 3: Save \$20 when you spend \$200',
              value: _rule3Enabled,
              onChanged: (value) {
                setState(() {
                  _rule3Enabled = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Goal',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800]),
              ),
            ),
            // --- Updated Circular Progress Goal Card ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 2,
                shadowColor: Colors.teal.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: 1200 / 3000,
                              strokeWidth: 7,
                              backgroundColor: Colors.teal[50],
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.teal),
                            ),
                            Center(
                              child: Text(
                                '${((1200 / 3000) * 100).toInt()}%',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vacation Fund',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '\$1,200 / \$3,000 saved',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.grey[400], size: 16),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'AI Suggestion',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Increase savings rule by +\$2',
                    style: TextStyle(color: Colors.teal[800])),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[600],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {},
                  child: Text('Apply', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // Helper widget to reduce code duplication for the switches
  Widget _buildRuleSwitch(
      {required String title,
        required bool value,
        required Function(bool) onChanged}) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(color: Colors.teal[800])),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.teal[600],
      activeTrackColor: Colors.teal[200],
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey[300],
    );
  }
}