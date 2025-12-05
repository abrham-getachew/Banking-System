import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'exchange_confirmation_page.dart';

class EnterAmountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Enter Amount to Exchange', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '1 USD = 0.93 EUR',
                style: TextStyle(fontSize: 16, color: Colors.teal[700]),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '+1.2%',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.teal),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              child: ExchangeRateChart(), // Replace CustomPaint with this
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'You will get ~93.00 EUR',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Fee: \$0.50 | Instant delivery',
                style: TextStyle(fontSize: 14, color: Colors.teal[700]),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExchangeConfirmScreen()),
                );},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[600],
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Review Exchange',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.view_module), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        selectedItemColor: Colors.teal[600],
        unselectedItemColor: Colors.grey[700],
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class ExchangeRateChart extends StatelessWidget {
  final List<double> spots = [
    0.92,  // Day 1
    0.93,  // Day 2
    0.915,  // Day 3
    0.945,  // Day 4
    0.93,  // Day 5
    0.935, // Day 6
    0.92,  // Day 1
    0.93,  // Day 2
    0.91,  // Day 3
    0.94,  // Day 4
    0.93,  // Day 5
    0.935,

  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 0.01,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 2,
          ),
        ),
        titlesData: FlTitlesData(
          show: false, // Hide titles for compact chart
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots
                .asMap()
                .entries
                .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                .toList(),
            isCurved: true,
            color: Colors.teal[700],
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false, // Hide dots for cleaner look
            ),
            belowBarData: BarAreaData(
              show: false,
            ),
          ),
        ],
        minX: 0,
        maxX: spots.length - 1.toDouble(),
        minY: 0.90,
        maxY: 0.95,
      ),
    );
  }
}