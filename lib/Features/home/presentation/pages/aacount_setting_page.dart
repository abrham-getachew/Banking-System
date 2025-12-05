import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.teal; // Brand color: Teal for TickPay

    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Light background similar to image
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Account & Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Profile Avatar
                      Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF5F5F5), // Light beige for avatar background
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.grey,
                            ), // Placeholder for profile image
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Name
                      const Text(
                        'John Carter',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      // Verified Member
                      Text(
                        'Verified Member',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Settings List
                ...List.generate(7, (index) => _buildSettingsItem(
                  context,
                  index,
                  primaryColor,
                )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor, // Teal for selected
        unselectedItemColor: Colors.grey.shade600,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            activeIcon: Icon(Icons.auto_awesome),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_in_ar_rounded),
            activeIcon: Icon(Icons.view_in_ar),
            label: 'BlockHub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'LifeX',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined),
            activeIcon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context, int index, Color primaryColor) {
    late IconData icon;
    late String title;
    late Color iconColor;

    switch (index) {
      case 0:
        icon = Icons.person_outline;
        title = 'Personal Info';
        break;
      case 1:
        icon = Icons.security_outlined;
        title = 'Security & Login';
        break;
      case 2:
        icon = Icons.link_outlined;
        title = 'Linked Accounts';
        break;
      case 3:
        icon = Icons.star_outline;
        title = 'Subscription Plans';
        break;
      case 4:
        icon = Icons.notifications_outlined;
        title = 'Notifications';
        break;
      case 5:
        icon = Icons.lock_outline;
        title = 'Privacy';
        break;
      case 6:
        icon = Icons.logout_outlined;
        title = 'Logout';
        break;
    }

    iconColor = primaryColor; // Teal for all icons to match brand

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          onTap: () {
            // Handle navigation based on title
            switch (title) {
              case 'Personal Info':
              // Navigate to personal info page
                break;
              case 'Security & Login':
              // Navigate to security page
                break;
              case 'Linked Accounts':
              // Navigate to linked accounts page
                break;
              case 'Subscription Plans':
              // Navigate to subscription page
                break;
              case 'Notifications':
              // Navigate to notifications page
                break;
              case 'Privacy':
              // Navigate to privacy page
                break;
              case 'Logout':
                _showLogoutDialog(context);
                break;
            }
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform logout action
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}