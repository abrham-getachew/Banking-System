import 'package:flutter/material.dart';

import '../../nav_page.dart';
import 'EducationGoalsScreen.dart';
import 'MicroCoursesScreen.dart';
import 'ScholarshipFinderScreen.dart';
import 'StudentLoansScreen.dart';
import 'TutorBookingScreen.dart';


class EducationLifeScreen extends StatefulWidget {
  @override
  _EducationLifeScreenState createState() => _EducationLifeScreenState();
}

class _EducationLifeScreenState extends State<EducationLifeScreen> {
  // --- NAVIGATION HANDLER ---
  // This function is called when any stat card or explore button is tapped.
  void _handleNavigation(String destination) {
    // For now, we'll just print to the console to show it's working.
    print('Navigating to $destination');


    Widget? page;
    switch (destination) {
      case 'Loan Balance':
      case 'Loans':
         page = StudentLoansScreen();
        break;
      case 'Active Goals':
         page = EducationGoalsScreen();
        break;
      case 'Scholarships':
         page = ScholarshipFinderScreen();
        break;
      case 'Courses':
         page = MicroCoursesScreen();
        break;
      case 'Tutors':
      case 'Mentors Booked':
         page = TutorBookingScreen();
        break;
    }

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Education Life',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Center(
                child: Text(
                  'Your education journey, powered by AI.',
                  style: TextStyle(
                    color: Colors.teal[800],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/education image1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Quick Stats',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
            ),
            // Responsive grid for Quick Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildStatsGrid(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Explore',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildExploreButton('Loans', Icons.credit_card),
                _buildExploreButton('Scholarships', Icons.school),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildExploreButton('Courses', Icons.book),
                _buildExploreButton('Tutors', Icons.people),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              child: Text(
                'AI Recommendations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
            ),
            // 70/30 AI Recommendations Section
            Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 7, // 70%
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Kevin.AI',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal[300]),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Unlock Your Potential\nDiscover personalized learning paths.',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[600],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () {},
                            child: Text('View Recommendations', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3, // 30%
                    child: Container(
                      height: 120,
                      margin: const EdgeInsets.only(right: 16.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/education image2.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
        bottomNavigationBar: MainScreen(selectedIndex: 3)
    );
  }

  // --- WIDGET BUILDER METHODS ---

  Widget _buildStatsGrid() {
    final List<Map<String, String>> stats = [
      {'title': 'Loan Balance', 'value': '\$12,500'},
      {'title': 'Active Goals', 'value': '3'},
      {'title': 'Mentors Booked', 'value': '2'},
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
          child: _buildStatCard(stats[index]['title']!, stats[index]['value']!),
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
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal[800], fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreButton(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.teal[100]!, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          minimumSize: Size(140, 60),
        ),
        onPressed: () => _handleNavigation(title),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.teal[800]),
            SizedBox(width: 8),
            Text(title, style: TextStyle(color: Colors.teal[800], fontSize: 16)),
          ],
        ),
      ),
    );
  }
}