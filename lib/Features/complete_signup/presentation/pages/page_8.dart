import 'package:chronos/Features/complete_signup/presentation/pages/page_9.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {},
        ),
        title: Text('TickPay', style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Start shopping with TickPay',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              'Split payments, stress free.',
              style: TextStyle(fontSize: 16, color: Colors.teal),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedShopPage(),
                    ),
                  );
                }




                ,style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                child: Text('Shop Now'),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: Colors.teal),
                  onPressed: () {},
                  tooltip: 'Home',
                ),
                IconButton(
                  icon: Icon(Icons.auto_awesome, color: Colors.teal),
                  onPressed: () {},
                  tooltip: 'AI',
                ),
                IconButton(
                  icon: Icon(Icons.view_quilt, color: Colors.teal),
                  onPressed: () {},
                  tooltip: 'BlockHub',
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.teal),
                  onPressed: () {},
                  tooltip: 'LifeX',
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz, color: Colors.teal),
                  onPressed: () {},
                  tooltip: 'More',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}