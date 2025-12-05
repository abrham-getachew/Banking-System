import 'package:flutter/material.dart';

import '../../nav_page.dart';



class ScholarshipFinderScreen extends StatefulWidget {
  @override
  _ScholarshipFinderScreenState createState() => _ScholarshipFinderScreenState();
}

class _ScholarshipFinderScreenState extends State<ScholarshipFinderScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> scholarships = [
    {
      'title': 'Academic Excellence Scholarship',
      'amount': '\$5,000',
      'deadline': 'May 15, 2024',
      'color': Color(0xFF4A5D4A), // Dark green to light gradient
    },
    {
      'title': 'STEM Innovators Grant',
      'amount': '\$7,500',
      'deadline': 'June 30, 2024',
      'color': Color(0xFF8B6F47), // Brown to light gradient
    },
    {
      'title': 'Global Leaders Scholarship',
      'amount': '\$10,000',
      'deadline': 'July 31, 2024',
      'color': Color(0xFF5C4033), // Dark brown to orange gradient
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('Scholarship Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.teal[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'AI Highlight',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '3 high-match scholarships found for you\nBased on your profile and academic achievements',
              style: TextStyle(color: Colors.teal),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: scholarships.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            scholarships[index]['color'],
                            scholarships[index]['color'].withOpacity(0.3),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              scholarships[index]['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${scholarships[index]['amount']} | Deadline: ${scholarships[index]['deadline']}',
                              style: TextStyle(color: Colors.white70),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Apply'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.teal, backgroundColor: Colors.teal[50],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Save & Apply Later'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.teal, backgroundColor: Colors.teal[50],
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
        bottomNavigationBar: MainScreen(selectedIndex: 3)
    );
  }
}