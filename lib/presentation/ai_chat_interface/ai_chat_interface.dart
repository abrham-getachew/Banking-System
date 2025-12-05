import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/ai_summary_card_widget.dart';
import './widgets/chat_input_widget.dart';
import './widgets/message_bubble_widget.dart';
import './widgets/quick_reply_chips_widget.dart';
import './widgets/typing_indicator_widget.dart';
import './widgets/voice_transcription_widget.dart';

class AiChatInterface extends StatefulWidget {
  const AiChatInterface({super.key});

  @override
  State<AiChatInterface> createState() => _AiChatInterfaceState();
}

class _AiChatInterfaceState extends State<AiChatInterface>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  final List<String> _quickReplies = [
    'Show my portfolio',
    'Investment advice',
    'Risk analysis',
    'Goal progress',
    'Market insights'
  ];

  bool _isTyping = false;
  bool _isRecording = false;
  bool _showTranscription = false;
  String _transcriptionText = '';
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;

  // Mock conversation data
  final List<Map<String, dynamic>> mockMessages = [
    {
      "id": 1,
      "message":
          "Hello! I'm your AI wealth advisor. How can I help you optimize your financial portfolio today?",
      "isUser": false,
      "timestamp": DateTime.now().subtract(const Duration(minutes: 5)),
      "type": "text"
    },
    {
      "id": 2,
      "message": "Can you show me my current investment performance?",
      "isUser": true,
      "timestamp": DateTime.now().subtract(const Duration(minutes: 4)),
      "type": "text"
    },
    {
      "id": 3,
      "message":
          "Based on your portfolio analysis, here's your current performance summary:",
      "isUser": false,
      "timestamp": DateTime.now().subtract(const Duration(minutes: 3)),
      "type": "summary_card",
      "cardData": {
        "title": "Portfolio Performance",
        "summary":
            "Your investments have grown 12.5% this quarter. Your tech stocks are performing exceptionally well, while your bond allocation provides stability.",
        "actionText": "View Full Portfolio",
        "cardType": "investment",
        "details": [
          {"label": "Total Return", "value": "+\$15,420"},
          {"label": "Best Performer", "value": "Tech ETF (+18.2%)"},
          {"label": "Risk Score", "value": "Moderate (6/10)"},
          {"label": "Diversification", "value": "Well Balanced"}
        ]
      }
    }
  ];

  @override
  void initState() {
    super.initState();
    _initializeChat();
    _fabAnimationController = AnimationController(
      duration: AppTheme.standardAnimation,
      vsync: this,
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    );
    _fabAnimationController.forward();
  }

  void _initializeChat() {
    setState(() {
      _messages.addAll(mockMessages);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        "id": _messages.length + 1,
        "message": text,
        "isUser": true,
        "timestamp": DateTime.now(),
        "type": "text"
      });
      _isTyping = true;
    });

    _textController.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 2), () {
      _generateAIResponse(text);
    });
  }

  void _generateAIResponse(String userMessage) {
    String response = "";
    Map<String, dynamic>? cardData;

    if (userMessage.toLowerCase().contains('portfolio') ||
        userMessage.toLowerCase().contains('investment')) {
      response = "I've analyzed your current portfolio. Here's what I found:";
      cardData = {
        "title": "Investment Recommendation",
        "summary":
            "Consider rebalancing your portfolio. I recommend increasing your exposure to emerging markets by 5% and reducing tech allocation slightly.",
        "actionText": "Apply Recommendation",
        "cardType": "investment",
        "details": [
          {"label": "Suggested Action", "value": "Rebalance Portfolio"},
          {"label": "Expected Return", "value": "+2.3% annually"},
          {"label": "Risk Impact", "value": "Minimal increase"},
          {"label": "Time Horizon", "value": "6-12 months"}
        ]
      };
    } else if (userMessage.toLowerCase().contains('goal')) {
      response = "Let me check your financial goals progress:";
      cardData = {
        "title": "Goal Progress Update",
        "summary":
            "You're 68% towards your house down payment goal! At your current savings rate, you'll reach your target 3 months ahead of schedule.",
        "actionText": "Adjust Goal",
        "cardType": "goal",
        "details": [
          {"label": "Target Amount", "value": "\$50,000"},
          {"label": "Current Progress", "value": "\$34,000 (68%)"},
          {"label": "Monthly Contribution", "value": "\$2,800"},
          {"label": "Estimated Completion", "value": "March 2025"}
        ]
      };
    } else if (userMessage.toLowerCase().contains('risk')) {
      response = "Here's your current risk analysis:";
      cardData = {
        "title": "Risk Assessment",
        "summary":
            "Your portfolio risk level is moderate. Your emergency fund covers 4.2 months of expenses, which is within the recommended range.",
        "actionText": "View Risk Details",
        "cardType": "risk",
        "details": [
          {"label": "Risk Score", "value": "6/10 (Moderate)"},
          {"label": "Emergency Fund", "value": "4.2 months coverage"},
          {"label": "Debt-to-Income", "value": "18% (Excellent)"},
          {"label": "Diversification", "value": "85% (Good)"}
        ]
      };
    } else {
      response =
          "I understand you're looking for financial guidance. I can help you with portfolio analysis, investment recommendations, goal tracking, and risk assessment. What specific area would you like to explore?";
    }

    setState(() {
      _messages.add({
        "id": _messages.length + 1,
        "message": response,
        "isUser": false,
        "timestamp": DateTime.now(),
        "type": cardData != null ? "summary_card" : "text",
        "cardData": cardData
      });
      _isTyping = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: AppTheme.standardAnimation,
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleMicPress() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _showTranscription = true;
      _transcriptionText = '';
    });

    // Simulate voice recognition
    Future.delayed(const Duration(seconds: 1), () {
      if (_isRecording) {
        setState(() {
          _transcriptionText = 'How is my portfolio performing this month?';
        });
      }
    });
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
      _showTranscription = false;
    });

    if (_transcriptionText.isNotEmpty) {
      _textController.text = _transcriptionText;
      _transcriptionText = '';
    }
  }

  void _handleQuickReply(String suggestion) {
    _textController.text = suggestion;
    _sendMessage();
  }

  void _handleMessageLongPress(Map<String, dynamic> message) {
    if (message['isUser'] == false) {
      showModalBottomSheet(
        context: context,
        backgroundColor: AppTheme.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
        ),
        builder: (context) => Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: AppTheme.dividerSubtle,
                  borderRadius: BorderRadius.circular(1.w),
                ),
              ),
              SizedBox(height: 3.h),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'copy',
                  color: AppTheme.chronosGold,
                  size: 6.w,
                ),
                title: Text(
                  'Copy Message',
                  style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                ),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: message['message']));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Message copied to clipboard'),
                      backgroundColor: AppTheme.successGreen,
                    ),
                  );
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'share',
                  color: AppTheme.chronosGold,
                  size: 6.w,
                ),
                title: Text(
                  'Share Insight',
                  style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Implement share functionality
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      );
    }
  }

  void _handleCardAction(String cardType) {
    switch (cardType) {
      case 'investment':
        Navigator.pushNamed(context, '/investment-portfolio');
        break;
      case 'goal':
        Navigator.pushNamed(context, '/financial-goals');
        break;
      case 'risk':
        Navigator.pushNamed(context, '/risk-analysis-dashboard');
        break;
      default:
        Navigator.pushNamed(context, '/ai-dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryCharcoal,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryCharcoal,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: CustomIconWidget(
              iconName: 'keyboard_arrow_down',
              color: AppTheme.textPrimary,
              size: 6.w,
            ),
          ),
        ),
        title: Row(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: AppTheme.chronosGold,
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'smart_toy',
                color: AppTheme.primaryCharcoal,
                size: 5.w,
              ),
            ),
            SizedBox(width: 3.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Wealth Advisor',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _isTyping ? 'Analyzing...' : 'Online',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: _isTyping
                        ? AppTheme.chronosGold
                        : AppTheme.successGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppTheme.surfaceDark,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(4.w)),
                ),
                builder: (context) => Container(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12.w,
                        height: 0.5.h,
                        decoration: BoxDecoration(
                          color: AppTheme.dividerSubtle,
                          borderRadius: BorderRadius.circular(1.w),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      ListTile(
                        leading: CustomIconWidget(
                          iconName: 'dashboard',
                          color: AppTheme.chronosGold,
                          size: 6.w,
                        ),
                        title: Text(
                          'Go to Dashboard',
                          style:
                              AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/ai-dashboard');
                        },
                      ),
                      ListTile(
                        leading: CustomIconWidget(
                          iconName: 'refresh',
                          color: AppTheme.chronosGold,
                          size: 6.w,
                        ),
                        title: Text(
                          'Clear Conversation',
                          style:
                              AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _messages.clear();
                            _initializeChat();
                          });
                        },
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: CustomIconWidget(
                iconName: 'more_vert',
                color: AppTheme.textPrimary,
                size: 6.w,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  _messages.clear();
                  _initializeChat();
                });
              },
              color: AppTheme.chronosGold,
              backgroundColor: AppTheme.surfaceDark,
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _isTyping) {
                    return const TypingIndicatorWidget();
                  }

                  final message = _messages[index];
                  final showTimestamp = index == 0 ||
                      DateTime.now()
                              .difference(message['timestamp'])
                              .inMinutes >
                          5;

                  if (message['type'] == 'summary_card' &&
                      message['cardData'] != null) {
                    final cardData =
                        message['cardData'] as Map<String, dynamic>;
                    return Column(
                      children: [
                        MessageBubbleWidget(
                          message: message['message'],
                          isUser: message['isUser'],
                          timestamp: message['timestamp'],
                          showTimestamp: showTimestamp,
                          onLongPress: () => _handleMessageLongPress(message),
                        ),
                        AiSummaryCardWidget(
                          title: cardData['title'],
                          summary: cardData['summary'],
                          actionText: cardData['actionText'],
                          cardType: cardData['cardType'],
                          details: (cardData['details'] as List?)
                              ?.cast<Map<String, dynamic>>(),
                          onActionPressed: () =>
                              _handleCardAction(cardData['cardType']),
                        ),
                      ],
                    );
                  }

                  return MessageBubbleWidget(
                    message: message['message'],
                    isUser: message['isUser'],
                    timestamp: message['timestamp'],
                    showTimestamp: showTimestamp,
                    onLongPress: () => _handleMessageLongPress(message),
                  );
                },
              ),
            ),
          ),
          if (_quickReplies.isNotEmpty && !_isTyping)
            QuickReplyChipsWidget(
              suggestions: _quickReplies,
              onSuggestionTapped: _handleQuickReply,
            ),
          VoiceTranscriptionWidget(
            transcriptionText: _transcriptionText,
            isVisible: _showTranscription,
            onClose: _stopRecording,
          ),
          ChatInputWidget(
            textController: _textController,
            onSendPressed: _sendMessage,
            onMicPressed: _handleMicPress,
            isRecording: _isRecording,
            isTyping: _isTyping,
          ),
        ],
      ),
    );
  }
}
