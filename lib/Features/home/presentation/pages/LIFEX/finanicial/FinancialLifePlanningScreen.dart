import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the chart package
import '../../nav_page.dart';

class FinancialLifePlanningScreen extends StatefulWidget {
  @override
  _FinancialLifePlanningScreenState createState() =>
      _FinancialLifePlanningScreenState();
}

class _FinancialLifePlanningScreenState
    extends State<FinancialLifePlanningScreen> {
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
          'Financial Life Planning',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        // Use a single ListView with zero padding for a scrollable, full-width header
        padding: EdgeInsets.zero,
        children: [
          // --- Top Banner Section ---
          Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24.0), // Add horizontal padding for text
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
                  'Your Financial Life',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Plan for your future with confidence. Set goals, track progress, and get personalized insights.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.5, // Improve line spacing for readability
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  onPressed: () {},
                  child: Text('Explore Goals', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

          // --- Vision Board Section ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 0, 16.0), // Adjust padding
            child: Text(
              'Vision Board',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800]),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding for the scroll view
            child: Row(
              children: [
                _buildVisionCard('Dream Home', 'Save \$500k by 2035',
                    'assets/images/financial image7.png'),
                SizedBox(width: 16),
                _buildVisionCard('Luxury Car', 'Save \$100k by 2030',
                    'assets/images/financial image8.png'),
                SizedBox(width: 16),
                _buildVisionCard('World Travel', 'Save \$200k by 2040',
                    'assets/images/financial image7.png'),
              ],
            ),
          ),

          // --- Retirement Forecast Section ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
            child: Text(
              'Retirement Forecast',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Projected Savings by Age 65',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '\$1.2M',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[800]),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '+15% vs last quarter',
                      style: TextStyle(color: Colors.green[600], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // --- Improved Line Chart ---
          Container(
            height: 150,
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
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
                          case 0: text = '2025'; break;
                          case 1: text = '2035'; break;
                          case 2: text = '2045'; break;
                          case 3: text = '2055'; break;
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
                      FlSpot(0, 0.8),
                      FlSpot(1, 1.5),
                      FlSpot(2, 1.4),
                      FlSpot(3, 2.2),
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
              ),
            ),
          ),

          // --- Emergency Fund Section ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
            child: Text(
              'Emergency Fund Tracker',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800]),
            ),
          ),
          _buildEmergencyFundTracker(),

          // --- AI Suggestion Section ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
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
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown[400]!, Colors.brown[800]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Consider increasing your monthly contribution by \$50 to reach your retirement goal 2 years earlier.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                ),
              ),
            ),
          ),
          SizedBox(height: 24), // Add final padding at the bottom
        ],
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- BUILDER WIDGETS ---

  Widget _buildVisionCard(String title, String subtitle, String imageUrl) {
    return Container(
      width: 200, // Increased width
      height: 200, // Increased height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), BlendMode.darken), // Darken image for text visibility
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(subtitle,
                style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyFundTracker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 2,
        shadowColor: Colors.teal.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.shield_outlined, color: Colors.teal[800], size: 28),
                  SizedBox(width: 12),
                  Text('Emergency Fund',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[800])),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$7,500 saved', style: TextStyle(color: Colors.grey[600])),
                  Text('Goal: \$10,000', style: TextStyle(color: Colors.grey[600])),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: 7500 / 10000,
                backgroundColor: Colors.teal[100],
                color: Colors.teal[600],
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}