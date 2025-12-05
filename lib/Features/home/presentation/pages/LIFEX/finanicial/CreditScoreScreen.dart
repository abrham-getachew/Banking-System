import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the chart package
import '../../nav_page.dart';

class CreditScoreScreen extends StatefulWidget {
  @override
  _CreditScoreScreenState createState() => _CreditScoreScreenState();
}

class _CreditScoreScreenState extends State<CreditScoreScreen> {
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
          'Credit Score',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Full-width top container
            Container(
              height: 250,
              width: double.infinity, // Set width to take full screen width
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal[600]!, Colors.teal[900]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '720',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Good',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {},
                    child: Text('View Full Report', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Score History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Last 6 Months',
                style: TextStyle(fontSize: 16, color: Colors.teal[800]),
              ),
            ),
            // 2. Corrected Line Chart using fl_chart
            Container(
              height: 150,
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(color: Colors.teal, fontSize: 12);
                          String text;
                          switch (value.toInt()) {
                            case 0: text = 'Jan'; break;
                            case 1: text = 'Feb'; break;
                            case 2: text = 'Mar'; break;
                            case 3: text = 'Apr'; break;
                            case 4: text = 'May'; break;
                            case 5: text = 'Jun'; break;
                            default: text = ''; break;
                          }
                          return SideTitleWidget(axisSide: meta.axisSide, child: Text(text, style: style));
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 700),
                        FlSpot(1, 710),
                        FlSpot(2, 705),
                        FlSpot(3, 715),
                        FlSpot(4, 718),
                        FlSpot(5, 720),
                      ],
                      isCurved: true,
                      color: Colors.teal,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.teal.withOpacity(0.2),
                      ),
                    ),
                  ],
                  minY: 690, // Set min/max to make the chart changes more visible
                  maxY: 730,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Factors',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.teal[300]),
              title: Text('Payment History', style: TextStyle(color: Colors.teal[800])),
              subtitle: Text('On Time', style: TextStyle(color: Colors.teal[300])),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.teal[300]),
              title: Text('Credit Utilization', style: TextStyle(color: Colors.teal[800])),
              subtitle: Text('Low', style: TextStyle(color: Colors.teal[300])),
            ),
            ListTile(
              leading: Icon(Icons.warning_amber_rounded, color: Colors.orange[300]),
              title: Text('Credit Age', style: TextStyle(color: Colors.teal[800])),
              subtitle: Text('Average', style: TextStyle(color: Colors.orange[300])),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'AI Tips',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
            ),
            // Added padding to the AI Tips container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 150, // Adjusted height
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal[600]!, Colors.teal[900]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Keep your credit utilization below 30% to see a potential score increase next month!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Add some space at the bottom
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}