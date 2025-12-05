import 'package:flutter/material.dart';
import 'NFT/NFT_home_page.dart';
import 'market_list.dart';
import 'nav_page.dart'; // Assuming MarketListPage is defined here

class BlockHubScreen extends StatefulWidget {
  @override
  _BlockHubScreenState createState() => _BlockHubScreenState();
}

class _BlockHubScreenState extends State<BlockHubScreen> {
  late PageController _marketController;
  bool isCryptoView = true; // Tracks the selected view (Crypto or NFT)
  bool showBalance = true;

  final List<Map<String, String>> marketData = [
    {'title': 'Bitcoin', 'price': '\$29,500', 'change': '+2.5%', 'image': 'assets/images/bitcoin.png'},
    {'title': 'Ethereum', 'price': '\$1,850', 'change': '+1.8%', 'image': 'assets/images/bitcoin.png'},
    {'title': 'Solana', 'price': '\$22', 'change': '-1.0%', 'image': 'assets/images/bitcoin.png'},
  ];

  @override
  void initState() {
    super.initState();
    _marketController = PageController(
      viewportFraction: 0.5, // Adjusted to show 20% of previous/next card
      initialPage: marketData.length * 500,
    );
  }

  @override
  void dispose() {
    _marketController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('BlockHub', style: TextStyle(color: Colors.black87)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.teal),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {


                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isCryptoView ? Colors.teal : Colors.teal[50],
                              borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                            ),
                            child: Text(
                              'Crypto',
                              style: TextStyle(
                                color: isCryptoView ? Colors.white : Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isCryptoView = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NftCollectionsPage(), // Navigate to NFT page
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: !isCryptoView ? Colors.teal : Colors.teal[50],
                              borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
                            ),
                            child: Text(
                              'NFT',
                              style: TextStyle(
                                color: !isCryptoView ? Colors.white : Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(height: 300,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Balance', style: Theme.of(context).textTheme.titleMedium)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        showBalance ? '\$10,000.00' : '**********',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      IconButton(
                        icon: Icon(showBalance ? Icons.visibility : Icons.visibility_off, color: Colors.teal),
                        onPressed: () {
                          setState(() {
                            showBalance = !showBalance;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),),


              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton('Buy', Icons.arrow_circle_down),
                  _buildActionButton('Sell', Icons.arrow_circle_up),
                  _buildActionButton('Withdraw', Icons.account_balance_wallet_outlined),
                  _buildActionButton('Swap', Icons.swap_horiz),
                  _buildActionButton('Deposit', Icons.add_card),
                ],
              ),
              SizedBox(height: 16),
              Text('Market Overview', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: PageView.builder(
                  controller: _marketController,
                  itemBuilder: (context, index) {
                    final int realIndex = index % marketData.length;
                    return AnimatedBuilder(
                      animation: _marketController,
                      child: _buildMarketCard(
                        marketData[realIndex]['title']!,
                        marketData[realIndex]['price']!,
                        marketData[realIndex]['change']!,
                        marketData[realIndex]['image']!,
                        realIndex, // Pass index for navigation
                      ),
                      builder: (context, child) {
                        double scale = 1.0;
                        if (_marketController.position.haveDimensions) {
                          double diff = (_marketController.page! - index).abs();
                          scale = 1 - (diff * 0.3);
                          scale = scale.clamp(0.6, 1.0); // Adjusted scale to show 20% visibility
                        } else {
                          int diff = (marketData.length * 500 - index).abs();
                          scale = 1 - (diff * 0.3);
                          scale = scale.clamp(0.6, 1.0); // Adjusted scale to show 20% visibility
                        }
                        return Transform.scale(
                          scale: scale,
                          child: Center(child: child),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 24),
              Text('Featured NFTs', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNFTCard('CryptoPunks', 'Floor: 75 ETH', 'assets/images/flower.png'),
                    _buildNFTCard('Bored Ape Yacht Club', 'Floor: 60 ETH', 'assets/images/flower.png'),
                    _buildNFTCard('Azuki', 'Floor: ', 'assets/images/flower.png'),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transaction History', style: Theme.of(context).textTheme.titleMedium),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.teal, size: 16),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.account_balance_wallet, color: Colors.teal),
                      title: Text('Transaction ${index + 1}'),
                      subtitle: Text('Completed at ${DateTime.now().subtract(Duration(hours: index)).toString()}'),
                      trailing: Text('\$${100 * (index + 1)}.00', style: TextStyle(color: Colors.green)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 2,),
    );
  }

  Widget _buildMarketCard(String title, String price, String change, String imagePath, int index) {
    Color changeColor = change.startsWith('+') ? Colors.green : (change.startsWith('-') ? Colors.red : Colors.black87);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Marketlist(), // Navigate to BlockHub page
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(22),
          ),
        ),
        child: Container(
          width: 180,
          height: 200,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(change, style: TextStyle(fontWeight: FontWeight.bold, color: changeColor)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNFTCard(String title, String floor, String imagePath) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>NftCollectionsPage(), // Navigate to NFT page
                ),
              );
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: 180,
                height: 200,
                child: Column(
                  children: [
                    Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(floor, style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          // Add more Card widgets here if needed
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.teal),
            onPressed: () {},
            iconSize: 24,
            padding: EdgeInsets.all(16),
          ),
        ),
        SizedBox(height: 4),
        Text(text, style: TextStyle(color: Colors.black87, fontSize: 12)),
      ],
    );
  }
}

// Placeholder for NftPage (create a full implementation as needed)
