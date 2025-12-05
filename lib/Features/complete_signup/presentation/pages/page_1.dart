import 'package:chronos/Features/complete_signup/presentation/pages/page_2.dart';
import 'package:flutter/material.dart';

class WhyUsechronsPage extends StatefulWidget {
  @override
  _WhyUseRevolutPageState createState() => _WhyUseRevolutPageState();
}

class _WhyUseRevolutPageState extends State<WhyUsechronsPage> {
  // Tracks selected options
  final Set<String> _selected = {};

  // Data model for sections + options
  final List<_Section> _sections = [
    _Section(
      title: 'Everyday needs',
      items: [
        _Item(name: 'Transfers', emoji: '💸'),
        _Item(name: 'Scheduling payments', emoji: '📝'),
        _Item(name: 'Metal card', emoji: '💳'),
        _Item(name: 'Cashback', emoji: '😊'),
        _Item(name: 'Budgeting', emoji: '✏️'),
        _Item(name: 'View accounts in one place', emoji: '📊'),
        _Item(name: 'Shopping deals', emoji: '🎁'),
        _Item(name: 'Get salary', emoji: '💰'),
        _Item(name: 'Kids account', emoji: '🎒'),
      ],
    ),
    _Section(
      title: 'Global spending',
      items: [
        _Item(name: 'Overseas transfers', emoji: '🌐'),
        _Item(name: 'Foreign exchange', emoji: '💱'),
        _Item(name: 'Spending abroad', emoji: '🛍️'),
        _Item(name: 'Airport lounge access', emoji: '✈️'),
        _Item(name: 'Hotel bookings', emoji: '🏨'),
      ],
    ),
    _Section(
      title: 'Investments',
      items: [
        _Item(name: 'Savings account', emoji: '👜'),
        _Item(name: 'Stocks', emoji: '📈'),
        _Item(name: 'Crypto', emoji: '🔒'),
        _Item(name: 'Invest in gold and silver', emoji: '🥇🥈'),
      ],
    ),
    _Section(
      title: 'Protections',
      items: [
        _Item(name: 'Disposable cards', emoji: '📱'),
        _Item(name: 'Purchase protection', emoji: '🛡️'),
      ],
    ),
  ];

  void _toggleSelection(String name) {
    setState(() {
      if (_selected.contains(name))
        _selected.remove(name);
      else
        _selected.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isContinueEnabled = _selected.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Status bar spacing
            SizedBox(height: 16),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'What do you want to use chronos for?',
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 8),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'We need to know this for regulatory reasons. And also, we’re curious!',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),

            SizedBox(height: 16),

            // Scrollable options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var section in _sections) ...[
                      Text(
                        section.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (var item in section.items)
                            _OptionChip(
                              item: item,
                              selected: _selected.contains(item.name),
                              onTap: () => _toggleSelection(item.name),
                            ),
                        ],
                      ),
                      SizedBox(height: 24),
                    ],
                  ],
                ),
              ),
            ),

            // Continue button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child:ElevatedButton(
                  onPressed: isContinueEnabled
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) =>  TailorRevolutApp()),
                    ); // handle continue
                    print('Continue with: $_selected');
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    disabledBackgroundColor: Colors.grey[300],
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.grey,
                  ),
                  child: Text('Continue' ,style: TextStyle(fontSize: 18)),
                )

                ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section {
  final String title;
  final List<_Item> items;
  const _Section({required this.title, required this.items});
}

class _Item {
  final String name;
  final String emoji;
  const _Item({required this.name, required this.emoji});
}

class _OptionChip extends StatelessWidget {
  final _Item item;
  final bool selected;
  final VoidCallback onTap;

  const _OptionChip({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = selected ? Colors.blue[100] : Colors.grey[200];
    final borderColor = selected ? Colors.blue : Colors.grey[300];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.emoji, style: TextStyle(fontSize: 18)),
            SizedBox(width: 6),
            Text(
              item.name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
