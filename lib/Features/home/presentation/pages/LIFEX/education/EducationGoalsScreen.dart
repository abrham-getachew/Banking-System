import 'package:flutter/material.dart';
import '../../nav_page.dart';

class EducationGoalsScreen extends StatefulWidget {
  @override
  _EducationGoalsScreenState createState() => _EducationGoalsScreenState();
}

class _EducationGoalsScreenState extends State<EducationGoalsScreen> {
  Map<String, int> goalProgress = {
    'Save \$5000 for MBA': 20,
    'Study Abroad in Europe': 50,
    'Learn Data Science': 75,
  };

  List<Map<String, dynamic>> milestones = [
    {'description': 'Start saving \$300/month', 'date': 'May 2024', 'completed': true}, // Mark first as completed for visual effect
    {'description': 'Complete 50% of savings', 'date': 'Oct 2024', 'completed': false},
    {'description': 'Reach \$5000 goal', 'date': 'Mar 2025', 'completed': false},
  ];

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
        title: Text('Education Goals', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vision Board',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), // Added radius
                      image: DecorationImage(
                        image: AssetImage('assets/images/education image3.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Icon(Icons.bar_chart, color: Colors.white, size: 40),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), // Added radius
                      image: DecorationImage(
                        image: AssetImage('assets/images/education image4.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text('STUDY GOAL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), // Added radius
                  image: DecorationImage(
                    image: AssetImage('assets/images/education image5.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.description, color: Colors.white, size: 40),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('+ Add New Goal'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.teal,
                  backgroundColor: Colors.teal[50],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Goal Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
              SizedBox(height: 10),
              ...goalProgress.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry.key, style: TextStyle(fontSize: 16, color: Colors.black)),
                            Text(entry.key.split(' ').last, style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        child: LinearProgressIndicator(
                          value: entry.value / 100,
                          backgroundColor: Colors.teal[50],
                          color: Colors.teal,
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text('${entry.value}%'),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: 20),
              Text(
                'Milestones',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
              SizedBox(height: 10),
              // --- Interconnected Milestones List ---
              Column(
                children: List.generate(milestones.length, (index) {
                  final milestone = milestones[index];
                  final isLast = index == milestones.length - 1;
                  return _buildMilestoneItem(
                    description: milestone['description']!,
                    date: milestone['date']!,
                    isCompleted: milestone['completed']!,
                    isLast: isLast,
                  );
                }),
              ),
              SizedBox(height: 20),
              Text(
                'AI Coaching',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'If you keep saving \$300/month, you\'ll reach your MBA goal in 14 months.',
                  style: TextStyle(color: Colors.teal[800], fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Helper Widget for Milestones ---
  Widget _buildMilestoneItem({
    required String description,
    required String date,
    required bool isCompleted,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // This column holds the circle and the connecting line
        Column(
          children: [
            Icon(
              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isCompleted ? Colors.teal : Colors.grey,
            ),
            // Draw the line if it's not the last item
            if (!isLast)
              Container(
                height: 50, // Height of the line between milestones
                width: 2,
                color: Colors.grey[300],
              ),
          ],
        ),
        SizedBox(width: 12),
        // This column holds the text content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
              SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}