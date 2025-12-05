import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'buy_screen.dart';



class CryptoScreen extends StatefulWidget {
  @override
  _CryptoScreenState createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  bool isLineSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {},
                  ),
                  Text(
                    'BTC/USDT',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            // Big pair name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'BTC/USDT',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '\$29,450.20',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            // Percentage change
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '1D +1.23%',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
            ),
            // Chart with margins and increased height
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 150,
                child: isLineSelected
                    ? LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 3),
                          FlSpot(0.5, 3.5),
                          FlSpot(1, 3.2),
                          FlSpot(1.5, 3.7),
                          FlSpot(2, 3),
                          FlSpot(2.5, 3.4),
                          FlSpot(3, 3.1),
                          FlSpot(3.5, 3.5),
                          FlSpot(4, 2.9),
                        ],
                        isCurved: true,
                        color: Colors.teal,
                        barWidth: 2,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                    minX: 0,
                    maxX: 4,
                    minY: 2,
                    maxY: 4,
                  ),
                )
                    : BarChart(
                  BarChartData(
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(toY: 3, color: Colors.teal),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(toY: 3.5, color: Colors.teal),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(toY: 3.2, color: Colors.teal),
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(toY: 3.7, color: Colors.teal),
                        ],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(toY: 3, color: Colors.teal),
                        ],
                      ),
                    ],
                    minY: 2,
                    maxY: 4,
                  ),
                ),
              ),
            ),
            // Time labels
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('10AM', style: TextStyle(color: Colors.grey)),
                  Text('12PM', style: TextStyle(color: Colors.grey)),
                  Text('2PM', style: TextStyle(color: Colors.grey)),
                  Text('4PM', style: TextStyle(color: Colors.grey)),
                  Text('6PM', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            // Chart type toggle
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLineSelected = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isLineSelected ? Colors.teal : Colors.teal[50],
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                          ),
                          child: Text('Line', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLineSelected = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: !isLineSelected ? Colors.teal : Colors.teal[50],
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
                          ),
                          child: Text('Candlestick', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 24h High/Low
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('24h High', style: TextStyle(color: Colors.grey)),
                      Text('\$29,500.00', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('24h Low', style: TextStyle(color: Colors.grey)),
                      Text('\$28,800.00', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey, thickness: 1),
            // Market Cap/Volume
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Market Cap', style: TextStyle(color: Colors.grey)),
                      Text('\$550B', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Volume', style: TextStyle(color: Colors.grey)),
                      Text('100K BTC', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey, thickness: 1),
            // Buy/Sell buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BuyScreen(), // Assuming MarketListPage is defined
                              ),
                            );

                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_upward, color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('Buy', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Sell action triggered')),
                          );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_downward, color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('Sell', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.view_in_ar), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}