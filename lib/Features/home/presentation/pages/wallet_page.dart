// WalletScreen definition
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card_detail.dart';
import 'cashout.dart';
import 'new_card.dart';

class WalletScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
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
              // Card Section (Scrollable)
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetailsScreen(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            child: Column(
                              children: [
                                Container(
                                  height: 120,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/disposal_card.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(child: Text('Disposable Card')),
                      ],
                    ),
                    SizedBox(width: 16),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetailsScreen(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            child: Column(
                              children: [
                                Container(
                                  height: 120,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/physical_card.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(child: Text('Disposable Card')),
                      ],
                    ),
                    SizedBox(width: 16),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetailsScreen(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            child: Column(
                              children: [
                                Container(
                                  height: 120,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/physical_card.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(child: Text('Disposable Card')),
                      ],
                    ),
                    SizedBox(width: 16),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetailsScreen(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            child: Column(
                              children: [
                                Container(
                                  height: 120,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/physical_card.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(child: Text('Disposable Card')),
                      ],
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              ),
              SizedBox(height: 14),
              // Quick Actions
              Text(
                'Quick actions',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(Icons.search, 'Find ATM'),

                      GestureDetector(
                        onTap: () {Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CashOutNearbyScreen()),
                        );
                        },
                        child: _buildActionButton(Icons.attach_money, 'Cash Out Nearby'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewCardScreen(),
                            ),
                          );
                        },
                        child: _buildActionButton(Icons.add_card, 'Add New Card'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(Icons.analytics, 'Wallet Analytics'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 44),
              // Recent Wallet Activity
              Text(
                'Recent Wallet Activity',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildActivityItem(Icons.credit_card, 'Purchase at Tech Store', '-\$45.20', 'Transaction'),
              _buildActivityItem(Icons.money_off, 'ATM Withdrawal', '-\$100.00', 'Cashout'),
              _buildActivityItem(Icons.card_membership, 'Online Subscription', '-\$12.99', 'Card Use'),
              SizedBox(height: 16),
            ],
          ),
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

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.teal,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildActivityItem(IconData icon, String title, String amount, String reason) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 18,
            child: Icon(icon, color: Colors.teal),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(reason, style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(amount, style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}