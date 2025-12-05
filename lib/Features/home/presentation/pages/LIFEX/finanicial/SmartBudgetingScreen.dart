import 'package:flutter/material.dart';

import '../../nav_page.dart';

class SmartBudgetingScreen extends StatefulWidget {
  @override
  _SmartBudgetingScreenState createState() => _SmartBudgetingScreenState();
}

class _SmartBudgetingScreenState extends State<SmartBudgetingScreen> {
  bool _isMonthly = true; // Toggle between monthly and weekly

  void _toggleView(bool value) {
    setState(() {
      _isMonthly = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Smart Budgeting',
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
            Text(
              'Spending Breakdown',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 16),
            Text(
              _isMonthly ? '\$1,200' : '\$280', // Example data change
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              _isMonthly ? 'This Month' : 'This Week',
              style: TextStyle(fontSize: 14, color: Colors.teal),
            ),
            SizedBox(height: 16),
            // This Row contains the bars with their labels included
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar('Food', _isMonthly ? 0.2 : 0.3),
                _buildBar('Rent', _isMonthly ? 0.5 : 0.5),
                _buildBar('Travel', _isMonthly ? 0.3 : 0.1),
                _buildBar('Ent.', _isMonthly ? 0.4 : 0.6), // Abbreviated for fit
                _buildBar('Other', _isMonthly ? 0.1 : 0.2),
              ],
            ),
            SizedBox(height: 24),
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal[800]!, Colors.teal[200]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'AI Budgeting Insights Here',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _toggleView(true),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.teal,
                    backgroundColor: _isMonthly ? Colors.teal[100] : Colors.grey[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
                  ),
                  child: Text('Monthly'),
                ),
                ElevatedButton(
                  onPressed: () => _toggleView(false),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.teal,
                    backgroundColor: !_isMonthly ? Colors.teal[100] : Colors.grey[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
                  ),
                  child: Text('Weekly'),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 16),
            _buildTransaction('Cafe Latte', 'Food', -5.50),
            _buildTransaction('Apartment Rent', 'Rent', -1500.00),
            _buildTransaction('Flight to Paris', 'Travel', -800.00),
            _buildTransaction('Movie Night', 'Entertainment', -20.00),
            _buildTransaction('Online Shopping', 'Other', -100.00),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle see all transactions action
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.teal,
                backgroundColor: Colors.teal[100],
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('See All Transactions'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // This widget now builds a Column with the bar and its corresponding label
  Widget _buildBar(String category, double heightFactor) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 120 * heightFactor, // Max height for a bar
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.teal[100],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 8), // Space between bar and label
          Text(
            category,
            style: TextStyle(color: Colors.teal, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTransaction(String title, String category, double amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
              Text(category, style: TextStyle(fontSize: 14, color: Colors.teal)),
            ],
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              color: amount < 0 ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}