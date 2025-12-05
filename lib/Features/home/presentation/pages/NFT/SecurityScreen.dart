import 'package:flutter/material.dart';



class SecurityScreen extends StatefulWidget {
  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool is2FAEnabled = false;
  bool isBiometricEnabled = false;

  List<Map<String, String>> connectedDevices = [
    {'name': 'iPhone 14 Pro', 'lastActive': '2 hours ago'},
    {'name': 'MacBook Pro', 'lastActive': '3 days ago'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('Security'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Two-Factor Authentication',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Row(
                children: [
                  Icon(Icons.shield, color: Colors.teal),
                  SizedBox(width: 10),
                  Text('Enable 2FA'),
                ],
              ),
              subtitle: Text('Enhance account security with a code from your authenticator app.'),
              value: is2FAEnabled,
              onChanged: (value) {
                setState(() {
                  is2FAEnabled = value;
                });
              },
              activeColor: Colors.teal,
            ),
            SizedBox(height: 20),
            Text(
              'Biometric Authentication',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Row(
                children: [
                  Icon(Icons.fingerprint, color: Colors.teal),
                  SizedBox(width: 10),
                  Text('Enable Biometrics'),
                ],
              ),
              subtitle: Text('Use your fingerprint or facial recognition to unlock the app.'),
              value: isBiometricEnabled,
              onChanged: (value) {
                setState(() {
                  isBiometricEnabled = value;
                });
              },
              activeColor: Colors.teal,
            ),
            SizedBox(height: 20),
            Text(
              'Connected Devices',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: connectedDevices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      index == 0 ? Icons.phone_iphone : Icons.laptop,
                      color: Colors.teal,
                    ),
                    title: Text(connectedDevices[index]['name']!),
                    subtitle: Text('Last active: ${connectedDevices[index]['lastActive']}'),
                    trailing: Icon(Icons.chevron_right, color: Colors.teal),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.block), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}