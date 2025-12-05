import 'package:flutter/material.dart';

class DetailedShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shop Now', style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFFFFFFF),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.grey[300]),
                    onPressed: () {},
                    child: Text('Fashion', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.grey[300]),
                    onPressed: () {},
                    child: Text('Tech', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.grey[300]),
                    onPressed: () {},
                    child: Text('Travel', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.grey[300]),
                    onPressed: () {},
                    child: Text('Essential', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(16.0),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: [
                  _buildDetailedShopItem(
                    context,
                    icon: Icons.store,
                    title: 'Cataoory',
                    subtitle: 'Up to 7% so...',
                  ),
                  _buildDetailedShopItem(
                    context,
                    icon: Icons.local_mall,
                    title: 'Sooa!-T',
                    subtitle: 'Shopongr',
                  ),
                  _buildDetailedShopItem(
                    context,
                    icon: Icons.local_offer,
                    title: 'Local Marchante',
                    subtitle: 'Up to 10% oadhiheok',
                  ),
                  _buildDetailedShopItem(
                    context,
                    icon: Icons.local_grocery_store,
                    title: 'Walnivart',
                    subtitle: 'Up to 6% oacnbeck',
                  ),
                  _buildDetailedShopItem(
                    context,
                    icon: Icons.store,
                    title: 'Cataoory',
                    subtitle: 'Up to 7% so...',
                  ),
                  _buildDetailedShopItem(
                    context,
                    icon: Icons.local_mall,
                    title: 'Sooa!-T',
                    subtitle: 'Shopongr',
                  ),
                  _buildDetailedShopItem(
                    context,
                    icon: Icons.local_offer,
                    title: 'Local Marchante',
                    subtitle: 'Up to 10% oadhiheok',
                  ),
                  _buildDetailedShopItem(
                    context,
                    icon: Icons.local_grocery_store,
                    title: 'Walnivart',
                    subtitle: 'Up to 6% oacnbeck',
                  ),
                  _buildDetailedShopItem(
                    context,
                    icon: Icons.store,
                    title: 'Cataoory',
                    subtitle: 'Up to 7% so...',
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.home, color: Colors.teal),
                        onPressed: () {},
                        tooltip: 'Home',
                      ),
                      Text('Home', style: TextStyle(color: Colors.teal)),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.auto_awesome, color: Colors.teal),
                        onPressed: () {},
                        tooltip: 'AI',
                      ),
                      Text('AI', style: TextStyle(color: Colors.teal)),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.view_quilt, color: Colors.teal),
                        onPressed: () {},
                        tooltip: 'BlockHub',
                      ),
                      Text('BlockHub', style: TextStyle(color: Colors.teal)),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.teal),
                        onPressed: () {},
                        tooltip: 'LifeX',
                      ),
                      Text('LifeX', style: TextStyle(color: Colors.teal)),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.more_horiz, color: Colors.teal),
                        onPressed: () {},
                        tooltip: 'More',
                      ),
                      Text('More', style: TextStyle(color: Colors.teal)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedShopItem(BuildContext context, {required IconData icon, required String title, required String subtitle}) {
    return Column(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.orange[200],
            child: Center(
              child: Icon(icon, size: 50, color: Colors.black87),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 10, color: Colors.teal),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}