import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the chart package
import '../../nav_page.dart';

class StudentLoansScreen extends StatefulWidget {
  @override
  _StudentLoansScreenState createState() => _StudentLoansScreenState();
}

class _StudentLoansScreenState extends State<StudentLoansScreen> {
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
          'Student Loans',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // Set the background to white
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            // --- Top Card with Loan Balance ---
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown[200]!, Colors.brown[400]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remaining Balance',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$12,450',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '35% Paid Off',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // --- Repayment History Section ---
            Text(
              'Repayment History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\$1,200',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Changed from white
              ),
            ),
            Text(
              'Last 12 Months +12%',
              style: TextStyle(
                fontSize: 14,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 16),

            // --- Line Chart ---
            Container(
              height: 120,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1),
                        FlSpot(1, 1.5),
                        FlSpot(2, 1.4),
                        FlSpot(3, 3.4),
                        FlSpot(4, 2),
                        FlSpot(5, 2.2),
                        FlSpot(6, 1.8),
                      ],
                      isCurved: true,
                      color: Colors.teal,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.teal.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // --- Next Payment Reminder ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next Payment Reminder',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Due: July 15, 2024',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600], // Changed from white70
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$250',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Changed from white
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Changed from white
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.grey[700], // Changed from grey
                    size: 40,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // --- AI Suggestion ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Suggestion',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Explore refinance options or smart repayment plans',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600], // Changed from white70
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.teal[50], // Changed from white
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: Colors.teal,
                    size: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // --- Explore Button ---
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle explore action
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.teal,
                  backgroundColor: Colors.teal[100],
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Explore'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}