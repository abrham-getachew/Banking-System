import 'package:flutter/material.dart';



class LoansMortgagesScreen extends StatefulWidget {
  @override
  _LoansMortgagesScreenState createState() => _LoansMortgagesScreenState();
}

class _LoansMortgagesScreenState extends State<LoansMortgagesScreen> {
  int _selectedIndex = 2; // Default to BlockHub tab
  DateTime _currentDate = DateTime(2025, 10, 25); // Current date: October 25, 2025

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime nextPaymentDue = _currentDate.add(Duration(days: 14)); // Due in 14 days

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Loans & Mortgages',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/financial image5.png'), // Replace with actual house image URL
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Mortgage',
              style: TextStyle(fontSize: 16, color: Colors.teal),
            ),
            Text(
              '\$180,000 remaining',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              '40% paid off',
              style: TextStyle(fontSize: 14, color: Colors.teal),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next Payment',
                      style: TextStyle(fontSize: 16, color: Colors.teal),
                    ),
                    Text(
                      'Due in 14 days',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                Text(
                  '\$1,250',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Repayment Plan Comparison',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 16),
            Text(
              'Projected Savings',
              style: TextStyle(fontSize: 16, color: Colors.teal),
            ),
            Text(
              '\$4,500',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              'Over 5 years +15%',
              style: TextStyle(fontSize: 14, color: Colors.teal),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPlanBar('Refinance', 0.6),
                _buildPlanBar('Current Plan', 0.4),
              ],
            ),
            SizedBox(height: 24),
            Card(
              color: Colors.teal[50],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Suggestion',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Refinancing your mortgage could save you \$4,500 over the next 5 years. Explore options to lower your monthly payments.',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle explore refinancing action
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('Explore Refinancing'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.teal), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome, color: Colors.teal), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.view_in_ar, color: Colors.teal), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite, color: Colors.teal), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz, color: Colors.teal), label: 'More'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildPlanBar(String label, double heightFactor) {
    return Container(
      width: 50,
      height: 100 * heightFactor,
      color: Colors.teal[100],
      margin: EdgeInsets.symmetric(horizontal: 8),
    );
  }
}