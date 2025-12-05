import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Theme Colors and Constants ---
const Color _kDarkTextColor = Color(0xFF333333);
const Color _kLightTextColor = Color(0xFF666666);
const Color _kChatInputFillColor = Color(0xFFF0F0F0); // Light grey fill for chat input
const Color _kIconColor = Color(0xFF333333);
const Color _kLifeXSelectedColor = Color(0xFF333333); // Black/Dark color for the selected LifeX tab

class FaithEventProgramsScreen extends StatefulWidget {
  const FaithEventProgramsScreen({super.key});

  @override
  State<FaithEventProgramsScreen> createState() => _FaithEventProgramsScreenState();
}

class _FaithEventProgramsScreenState extends State<FaithEventProgramsScreen> {
  // --- State Variables ---
  int _selectedIndex = 3; // Initial selection for 'LifeX' tab (index 3)
  final TextEditingController _chatController = TextEditingController();
  List<Map<String, String>> _messages = [
    {'name': 'Sophia Carter', 'time': '10:30 AM', 'text': 'This is so inspiring! Thank you for sharing.', 'avatar': 'assets/avatar_sophia.png'},
    {'name': 'Ethan Bennett', 'time': '10:35 AM', 'text': 'The energy is amazing. Feeling so connected.', 'avatar': 'assets/avatar_ethan.png'},
    {'name': 'Olivia Hayes', 'time': '10:40 AM', 'text': 'Absolutely beautiful. The visuals and message are perfect.', 'avatar': 'assets/avatar_olivia.png'},
  ];

  // --- Life Cycle Methods ---
  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic here
  }

  void _sendMessage() {
    String text = _chatController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({
          'name': 'Me (User)',
          'time': 'Just now',
          'text': text,
          'avatar': 'assets/avatar_user.png', // Placeholder for user avatar
        });
        _chatController.clear();
      });
      // In a real app, this would send the message to a server
      print('Message Sent: $text');
    }
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: _kDarkTextColor),
        title: const Text(
          'Faith Event Programs',
          style: TextStyle(color: _kDarkTextColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      // 2. Body Content
      body: Column(
        children: <Widget>[
          // Video Player Placeholder
          _buildVideoPlayerPlaceholder(context),

          // Live Chat Section Title
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Text(
              'Live Chat',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _kDarkTextColor,
              ),
            ),
          ),

          // Chat Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildChatMessage(_messages[index]);
              },
            ),
          ),

          // Chat Input Field
          _buildChatInput(),

          // 3. Bottom Navigation Bar

        ],
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Component Builders ---

  Widget _buildVideoPlayerPlaceholder(BuildContext context) {
    // Aspect ratio of 16:9 is common for video players.
    double height = MediaQuery.of(context).size.width / (16 / 9);

    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.black, // Dark background for video
        image: DecorationImage(
          image: AssetImage('assets/video_placeholder.png'), // Replace with your image
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black38, // Slightly darken the image for the play button
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.play_arrow,
              size: 48,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatMessage(Map<String, String> message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(message['avatar']!), // Replace with NetworkImage if necessary
          ),
          const SizedBox(width: 10),
          // Message Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      message['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: _kDarkTextColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      message['time']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: _kLightTextColor.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message['text']!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: _kDarkTextColor,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // User Avatar (Cloning the avatar on the left of the input field)
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/avatar_user.png'), // Replace with user's actual avatar
          ),
          const SizedBox(width: 10),
          // Text Input Field
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: _kChatInputFillColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _chatController,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: _kLightTextColor.withOpacity(0.7)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.image_outlined, color: _kLightTextColor),
                    onPressed: () {
                      // Handle media upload
                      print('Media upload pressed');
                    },
                  ),
                ),
                style: const TextStyle(color: _kDarkTextColor),
              ),
            ),
          ),
          // Send Button (Optional, can rely on textInputAction.send)
          // For a cleaner clone, we'll rely on the text input action/keyboard button.
        ],
      ),
    );
  }


}