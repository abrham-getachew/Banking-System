import 'package:flutter/material.dart';

import '../../nav_page.dart';



class TutorBookingScreen extends StatefulWidget {
  @override
  _TutorBookingScreenState createState() => _TutorBookingScreenState();
}

class _TutorBookingScreenState extends State<TutorBookingScreen> {
  DateTime _selectedDate = DateTime(2024, 7, 5); // Default selected date
  int _selectedIndex = 2; // Default to BlockHub tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

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
          'Tutor & Mentor Booking',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), // Added radius
                image: DecorationImage(
                  image: AssetImage('assets/images/education image6.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'July 2024',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Icon(Icons.chevron_right, color: Colors.teal),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 200,
              child: GridView.count(
                crossAxisCount: 7,
                children: List.generate(31, (index) {
                  final day = index + 1;
                  final date = DateTime(2024, 7, day);
                  return GestureDetector(
                    onTap: () => _selectDate(date),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: date.day == _selectedDate.day && date.month == _selectedDate.month && date.year == _selectedDate.year
                            ? Colors.teal
                            : null,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          day.toString(),
                          style: TextStyle(
                            color: date.day == _selectedDate.day && date.month == _selectedDate.month && date.year == _selectedDate.year
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Available Mentors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 16),
            _buildMentorCard('Anaya Sharma', 'Mathematics', 4.7, 'assets/images/education image7.png'), // Replace with actual image URL
            _buildMentorCard('Ethan Carter', 'Physics', 4.7, 'assets/images/education image8.png'),
            _buildMentorCard('Olivia Bennett', 'Chemistry', 4.8, 'assets/images/education image9.png'),
            _buildMentorCard('Noah Thompson', 'Biology', 4.7, 'assets/images/education image10.png'),
            _buildMentorCard('Sophia Ramirez', 'Computer Science', 4.9, 'assets/images/education image11.png'),
            _buildMentorCard('Liam Walker', 'English Literature', 4.7, 'assets/images/education image12.png'),
          ],
        ),
      ),
        bottomNavigationBar: MainScreen(selectedIndex: 3)
    );
  }

  Widget _buildMentorCard(String name, String subject, double rating, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  subject,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.teal),
                    Text(
                      rating.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.teal),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle book now action
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.teal, backgroundColor: Colors.teal[100],
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Book Now'),
          ),
        ],
      ),
    );
  }
}