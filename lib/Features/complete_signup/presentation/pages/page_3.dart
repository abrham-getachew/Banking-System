import 'package:chronos/Features/complete_signup/presentation/pages/page_4.dart';
import 'package:flutter/material.dart';

// Data model for each plan
class Plan {
  final String key;
  final String title;
  final String subtitle;
  final String badgeText;
  final Color badgeColor;
  final String priceText;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final List<String> features;

  Plan({
    required this.key,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.badgeColor,
    required this.priceText,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.features,
  });
}

class PlanSelectionPage extends StatefulWidget {
  @override
  _PlanSelectionPageState createState() => _PlanSelectionPageState();
}

class _PlanSelectionPageState extends State<PlanSelectionPage> {
  // Define the four plans
  final List<Plan> _plans = [
    Plan(
      key: 'Metal',
      title: 'Metal',
      subtitle: 'The ultimate experience',
      badgeText: '⚡ Popular',
      badgeColor: Colors.white,
      priceText: '£12.99/month',
      buttonText: 'Get Metal for £12.99/m',
      buttonColor: Colors.black,
      buttonTextColor: Colors.white,
      features: [
        'Unlimited foreign exchange Mon–Fri in 36+ currencies',
        '10 commission-free trades/month; other fees may apply',
        'International travel insurance up to £10M (£50 excess)',
      ],
    ),
    Plan(
      key: 'Premium',
      title: 'Premium',
      subtitle: 'Ticket to a global lifestyle',
      badgeText: '🎁 Special Offer',
      badgeColor: Colors.white,
      priceText: '1 month free then £6.99/month',
      buttonText: 'Start your free trial',
      buttonColor: Colors.black,
      buttonTextColor: Colors.white,
      features: [
        'Unlimited foreign exchange Mon–Fri in 36+ currencies',
        '10 commission-free trades/month; other fees may apply',
        'International travel insurance up to £10M (£50 excess)',
      ],
    ),
    Plan(
      key: 'Plus',
      title: 'Plus',
      subtitle: 'Best for everyday spending',
      badgeText: '🎁 Special Offer',
      badgeColor: Colors.white,
      priceText: '1 month free then £2.99/month',
      buttonText: 'Start your free trial',
      buttonColor: Colors.black,
      buttonTextColor: Colors.white,
      features: [
        '10 commission-free trades/month; other fees may apply',
        'Purchase protection up to £1,000/year for eligible items',
      ],
    ),
    Plan(
      key: 'Standard',
      title: 'Standard',
      subtitle: 'Active — free',
      badgeText: '✔ Active',
      badgeColor: Colors.white,
      priceText: 'Free',
      buttonText: 'Get Standard for free',
      buttonColor: Colors.black,
      buttonTextColor: Colors.white,
      features: [
        'Exchange in 36+ currencies up to £1,000/mo at interbank rate',
        '1 commission-free trade/month; other fees may apply',
        'Revolut <18 accounts for ages 6–17',
      ],
    ),
  ];

  int _selectedIndex = 0; // default to Standard

  @override
  Widget build(BuildContext context) {
    final Plan current = _plans[_selectedIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with Skip
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 2.0),
              child: Row(
                children: [


                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // Skip action
                    },
                    child: Text('Skip', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 150,bottom: 20),
              child: Text("Select Plan",style: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.bold,fontSize: 44
              ),),
            ),
            // Horizontal plan selector
            Container(

              height: 52,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _plans.length,
                separatorBuilder: (_, __) => SizedBox(width: 12),
                itemBuilder: (context, idx) {
                  final plan = _plans[idx];
                  final isSelected = idx == _selectedIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = idx;
                      });
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color:
                        isSelected ? Colors.grey[300] : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          plan.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                            color:
                            isSelected ? Colors.black : Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 24),

            // Plan details
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Container( // Badge + Title + Subtitle
                     height: 150,
                       padding: EdgeInsets.only(left: 15,top: 15),
                       decoration: BoxDecoration(

                         color: Colors.black,
                         borderRadius: BorderRadius.circular(12),
                       ),

                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           children: [
                             Expanded(
                               child: Text(
                                 current.title,
                                 style: TextStyle(
                                   fontSize: 50,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.white,
                                 ),
                                 overflow: TextOverflow.ellipsis,
                                 maxLines: 1,
                               ),
                             ),
                             if (current.badgeText.isNotEmpty)
                               Padding(
                                 padding: EdgeInsets.only(right: 12), // Right margin from screen edge
                                 child: Container(
                                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                   decoration: BoxDecoration(
                                     color: current.badgeColor,
                                     borderRadius: BorderRadius.circular(12),
                                   ),
                                   child: Text(
                                     current.badgeText,

                                     style: TextStyle(
                                       color: Colors.black,
                                       fontSize: 14,
                                       fontWeight: FontWeight.bold
                                     ),
                                     overflow: TextOverflow.ellipsis,
                                     maxLines: 1,
                                   ),
                                 ),
                               ),
                           ],
                         ),

                         SizedBox(height: 16),
                         Text(
                           current.priceText,
                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),
                         ),
                         Text(
                           current.subtitle,
                           style: TextStyle(fontSize: 16, color: Colors.white),
                         ),
                         SizedBox(height: 4),

                         // Price

                       ],
                     )



                   ),
                    SizedBox(height: 24),

                    // Features list
                    for (var feat in current.features) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check, size: 20, color: Colors.blue),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              feat,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                    ],

                    SizedBox(height: 24),
                    Divider(),
                    SizedBox(height: 8),

                    // Footer note
                    Text(
                      'This is a 12-month plan. By proceeding you agree to our Terms & Conditions and Insurance Documents.',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),

                    SizedBox(height: 48),
                  ],
                ),
              ),
            ),

            // Bottom action button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) =>  GetCardScreen()),
                    );  // Handle plan purchase/trial
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: current.buttonColor,
                  ),
                  child: Text(
                    current.buttonText,
                    style: TextStyle(
                      color: current.buttonTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
