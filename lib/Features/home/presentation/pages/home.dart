import 'package:chronos/Features/home/presentation/pages/transfer_money.dart';
import 'package:chronos/Features/home/presentation/pages/wallet_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../complete_signup/presentation/pages/page_7.dart';
import 'aacount_setting_page.dart';
import 'add_money_page.dart';
import 'cashout.dart';
import 'exchange.dart';
import 'nav_page.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _isBalanceVisible = true;

  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountSettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Search services, transactions or help',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade700, Colors.teal.shade900],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total Balance:',
                      style: TextStyle(color: Colors.white70, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _isBalanceVisible ? '\$12,450.25' : '****',
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(
                            _isBalanceVisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: _toggleBalanceVisibility,
                        ),
                        Chip(
                          label: const Text('USD', style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.blue,
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SendMoneyScreen()),
                    );},
                    icon: const Icon(Icons.arrow_outward, color: Colors.teal),
                    label: const Text('Transfer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddMoneyScreen()),
                    );},

                    icon: const Icon(Icons.add, color: Colors.teal),
                    label: const Text('Add Money'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () { Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExchangeScreen()),
                      );},
                      icon: const Icon(Icons.currency_exchange, color: Colors.teal),
                      label: const Text('\$ Exchange'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WalletScreens()),
                      );},
                      icon: const Icon(Icons.wallet, color: Colors.teal),
                      label: const Text('Wallet'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TickPayScreen()),
                      );},
                      icon: const Icon(Icons.credit_card, color: Colors.teal),
                      label: const Text('TickPay'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz, color: Colors.teal),
                      label: const Text('More'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.lightbulb, color: Colors.teal),
                title: const Text('Utilities'),
                subtitle: const Text('11/28/2024'),
                trailing: const Text('-150', style: TextStyle(color: Colors.red)),
              ),
              const SizedBox(height: 24),
              const Text(
                'AI Insights',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              color: Colors.grey.shade200,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Portfolio outperforming market by 3% this week',
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Updated 12/06/2024',
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              color: Colors.grey.shade200,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Investment in renewable energy showing strong returns',
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Updated 12/06/2024',
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Monthly Spending Analysis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: Colors.blue,
                        value: 40,
                        title: '',
                        radius: 50,
                      ),
                      PieChartSectionData(
                        color: Colors.orange,
                        value: 30,
                        title: '',
                        radius: 50,
                      ),
                      PieChartSectionData(
                        color: Colors.purple,
                        value: 30,
                        title: '',
                        radius: 50,
                      ),
                    ],
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 60,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                color: Colors.teal.shade700,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Net Worth Summary',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Cash \$7,200, TickPay \$500, AI Portfolio \$2,000, BlockHub \$1,800, Investments \$950',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 0,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal.shade700,
        child: const Icon(Icons.waves, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
