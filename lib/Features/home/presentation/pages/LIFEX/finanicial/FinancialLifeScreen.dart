import 'package:flutter/material.dart';
import '../../nav_page.dart';

import 'FinancialLifePlanningScreen.dart';
import 'InvestmentAdvice.dart';
import 'AutomaticSavingPlansScreen.dart';
import 'LoansMortgagesScreen.dart';
import 'SmartBudgetingScreen.dart';
import 'TaxFilingAssistanceScreen.dart';

class FinancialLifeScreen extends StatefulWidget {
  @override
  _FinancialLifeScreenState createState() => _FinancialLifeScreenState();
}

class _FinancialLifeScreenState extends State<FinancialLifeScreen> {
  // --- NAVIGATION HANDLER ---
  void _handleNavigation(String destination) {
    print('Navigating to $destination');

    Widget? page;
    switch (destination) {
      case 'Budgeting':
        page = SmartBudgetingScreen();
        break;
      case 'Savings':
       page = AutomaticSavingPlansScreen();
        break;
      case 'Investments':
        page = InvestmentAdviceScreen();
        break;
      case 'Loans':
        //page = CreditScoreScreen();
        page = LoansMortgagesScreen();
        break;
      case 'Taxes':
        page = TaxFilingAssistanceScreen();
        break;
      case 'Planning':
        page = FinancialLifePlanningScreen();
        break;
      // ... etc.
    }

    if (page != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Financial Life',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Your financial life dashboard',
                  style: TextStyle(fontSize: 18, color: Colors.teal[800], fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage('assets/images/financial image1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Quick Stats',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
              SizedBox(height: 10),
              // --- Updated Quick Stats Grid ---
              _buildStatsGrid(),
              SizedBox(height: 20),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4A5D4A), Color(0xFFF5E6CC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    'AI Financial Insights Coming Soon',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
              SizedBox(height: 10),
              // --- Updated Actions Grid ---
              _buildActionsGrid(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- WIDGET BUILDER FOR STATS ---
  Widget _buildStatsGrid() {
    final List<Map<String, dynamic>> stats = [
      {'title': 'Spending', 'value': '\$1,200'},
      {'title': 'Savings', 'value': '75%'},
      {'title': 'Credit Score', 'value': '720'},
    ];
    const double spacing = 16.0;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      children: List.generate(stats.length, (index) {
        bool isLastItemAndOdd = (index == stats.length - 1) && (stats.length % 2 != 0);
        double cardWidth = (MediaQuery.of(context).size.width - (16 * 2) - spacing) / 2;

        return Container(
          width: isLastItemAndOdd ? double.infinity : cardWidth,
          child: _buildStatCard(stats[index]['title']!, stats[index]['value']!.toString()),
        );
      }),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return InkWell(
      onTap: () => _handleNavigation(title),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.teal[100]!, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal[800], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BUILDER FOR ACTIONS ---
  Widget _buildActionsGrid() {
    final List<Map<String, dynamic>> actions = [
      {'label': 'Budgeting', 'icon': Icons.attach_money},
      {'label': 'Savings', 'icon': Icons.savings},
      {'label': 'Investments', 'icon': Icons.show_chart},
      {'label': 'Loans', 'icon': Icons.home},
      {'label': 'Taxes', 'icon': Icons.receipt},
      {'label': 'Planning', 'icon': Icons.calendar_today},
    ];
    const double spacing = 16.0;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      children: actions.map((action) {
        double cardWidth = (MediaQuery.of(context).size.width - (16 * 2) - spacing) / 2;
        return Container(
          width: cardWidth,
          child: _buildActionCard(action['label'], action['icon']),
        );
      }).toList(),
    );
  }

  Widget _buildActionCard(String label, IconData icon) {
    return InkWell(
      onTap: () => _handleNavigation(label),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.teal[100]!, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.teal[800], size: 30),
            SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal[800], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}