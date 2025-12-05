import 'package:chronos/Features/home/presentation/pages/select_recipient.dart';
import 'package:flutter/material.dart';

class SendMoneyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Send Money', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),)),
                 SizedBox(height: 15,),
                 Center(
                   child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://via.placeholder.com/40'),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://via.placeholder.com/40'),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://via.placeholder.com/40'),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://via.placeholder.com/40'),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://via.placeholder.com/40'),
                      ),
                    ],
                                   ),
                 ),


            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: '0.00',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Add annotation',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 320),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectRecipientScreen()),
                );},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Continue', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.view_module), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}