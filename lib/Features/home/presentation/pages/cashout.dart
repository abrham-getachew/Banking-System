import 'package:flutter/material.dart';
import 'dart:async';

import 'QR_page.dart';

class CashOutNearbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Static Google Map Image
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,

            ),
            child: Center(child:
              Text("Store",style: TextStyle(color: Colors.black),),
            ),

          ),
          // Content
          Column(
            children: [
              // App Bar with Back Button
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.white.withOpacity(0.8),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Text(
                        'Cash Out Nearby',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                color: Colors.white.withOpacity(0.8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              // Spacer to push content up
              Expanded(
                child: Container(),
              ),
            ],
          ),
          // Custom Zoom Controls (now decorative since map is static)
          Positioned(
            right: 16.0,
            bottom: 200.0,
            child: Column(
              children: [
                IconButton(icon: Icon(Icons.add), onPressed: () {}),
                IconButton(icon: Icon(Icons.remove), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Nearby Stores',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        leading:  Container(
                          width: 80,
                          
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(15)

                          ),
                          child: Center(child:
                          Text("Store",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                          ),

                        ),
                        title: Text('Store A'),
                        subtitle: Text('123 Main St, San Francisco, CA'),
                        trailing: Text('Max \$200'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CashOutPendingScreen()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Container(
          width: 80,

          decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(15)

          ),
          child: Center(child:
          Text("Store",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
          ),

          ),
                        title: Text('Store B'),
                        subtitle: Text('456 Oak Ave, San Francisco, CA'),
                        trailing: Text('Max \$500'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CashOutPendingScreen()),
                          );
                        },
                      ),
                      ListTile(
                        leading:Container(
                          width: 80,

                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(15)

                          ),
                          child: Center(child:
                          Text("Store",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                          ),

                        ),
                        title: Text('Store C'),
                        subtitle: Text('789 Pine Ln, San Francisco, CA'),
                        trailing: Text('Max \$300'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CashOutPendingScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.view_in_ar), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class CashOutPendingScreen extends StatefulWidget {
  @override
  _CashOutPendingScreenState createState() => _CashOutPendingScreenState();
}

class _CashOutPendingScreenState extends State<CashOutPendingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => QRCodeScreens()),
        );
      }
    });
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Cash Out'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cash Out Pending',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Processing',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Circular radius on corners
                child: LinearProgressIndicator(
                  value: _animation.value,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                  minHeight: 10,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your cash out request is being processed. You will receive a notification once it\'s complete.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.view_in_ar), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class QRCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Cash Out'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scan QR Code',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              color: Colors.grey, // Placeholder for QR code
              child: Center(
                child: Text(
                  'QR Code Here',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Present this QR code at the store to complete your cash out.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.view_in_ar), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}