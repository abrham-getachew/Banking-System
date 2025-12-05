import 'package:chronos/Features/home/presentation/pages/LIFEX/social/HealthLifeHubScreen.dart';
import 'package:chronos/Features/home/presentation/pages/LIFEX/spritual/spritualHomePageScreen.dart';
import 'package:chronos/Features/home/presentation/pages/LIFEX/vision/VisionLifeScreen.dart';
import 'package:flutter/material.dart';

// Import the new pages you will create
// ... import other pages as you create them

import '../nav_page.dart';
import 'education/EducationLifeScreen.dart';
import 'family/FamilyRelationshipScreen.dart';
import 'finanicial/FinancialLifeScreen.dart';
import 'health/InsuranceMarketplaceScreen.dart';
import 'health/health_hub.dart';
// Import your Health page, for example:
// import 'health/HealthLifeScreen.dart';

class LifeXScreen extends StatefulWidget {
  @override
  _LifeXScreenState createState() => _LifeXScreenState();
}

class _LifeXScreenState extends State<LifeXScreen> {
  Map<String, int> lifeCategories = {
    'Education': 60,
    'Financial': 80,
    'Health': 70,
    'Spiritual': 50,
    'Vision': 90,
    'Family': 75,
    'Social': 65,
  };

  int overallBalance = 70;
  int overallChange = 5;

  // Function to handle navigation
  void _navigateToCategoryPage(String categoryName) {
    Widget? page; // Make the 'page' variable nullable
    switch (categoryName) {
      case 'Education':
        page = EducationLifeScreen(); // Navigate to EducationPage
        break;
      case 'Financial':
        page = FinancialLifeScreen(); // Navigate to FinancialPage
        break;
      case 'Health':
        page = HealthLifeHubScreen();
      case 'Vision':
        page = VisionLifeScreen();
      case 'Social':
        page = LifeStageScreen();
      case 'Family':
        page = FamilyRelationshipScreen();
      case 'Spiritual':
        page = spritualHomePageScreen();


    // case 'Health':
    //  page = HealthLifeScreen(); // Uncomment and assign when Health page is ready
    //   break;
    // Add cases for other categories here
    // case 'Spiritual':
    //   page = SpiritualPage();
    //   break;
    // ... and so on
      default:
      // For any other category, 'page' will remain null
        break;
    }

    // Only navigate if a page has been assigned
    if (page != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LifeX'),
              SizedBox(width: 5),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Your Life Hub', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('via.placeholder.com/60'), // Placeholder image
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ...lifeCategories.entries.map((entry) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque, // Ensures the entire row area is tappable
                  onTap: () {
                    // Updated onTap to call the navigation function
                    _navigateToCategoryPage(entry.key);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjusted padding
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5E6CC),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(Icons.circle, color: Colors.transparent),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry.key, style: TextStyle(fontSize: 16, color: Colors.teal)),
                            Text('${entry.value}%', style: TextStyle(fontSize: 14, color: Colors.teal)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Set Goals'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.teal,
                      backgroundColor: Colors.teal[50],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Add Transactions'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.teal,
                      backgroundColor: Colors.teal[50],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Life Balance Wheel',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '$overallBalance%',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Overall +$overallChange%', style: TextStyle(color: Colors.green)),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(width: 10, height: 120, color: Colors.teal[50]),
                    Container(width: 10, height: 140, color: Colors.teal[50]),
                    Container(width: 10, height: 130, color: Colors.teal[50]),
                    Container(width: 10, height: 125, color: Colors.teal[50]),
                    Container(width: 10, height: 135, color: Colors.teal[50]),
                    Container(width: 10, height: 145, color: Colors.teal[50]),
                    Container(width: 10, height: 130, color: Colors.teal[50]),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['Edu', 'Fin', 'Hea', 'Spi', 'Vis', 'Fam', 'Soc']
                    .map((e) => Text(e, style: TextStyle(color: Colors.teal)))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}