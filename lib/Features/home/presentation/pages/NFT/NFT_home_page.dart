import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../block_hub_home.dart';

class NftCollectionsPage extends StatefulWidget {
  const NftCollectionsPage({super.key});

  @override
  State<NftCollectionsPage> createState() => _NftCollectionsPageState();
}

class _NftCollectionsPageState extends State<NftCollectionsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 2; // BlockHub is selected (index 2)
  bool isCryptoView = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('BlockHub', style: TextStyle(color: Colors.black87)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.teal),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
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
                          setState(() {
                            isCryptoView = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlockHubScreen(), // Navigate to Crypto page
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: !isCryptoView ? Colors.teal : Colors.teal[50],
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                          ),
                          child: Text(
                            'Crypto',
                            style: TextStyle(
                              color: !isCryptoView ? Colors.white : Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isCryptoView = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isCryptoView ? Colors.teal : Colors.teal[50],
                            borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
                          ),
                          child: Text(
                            'NFT',
                            style: TextStyle(
                              color: isCryptoView ? Colors.white : Colors.black87,
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
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.teal[200],
            indicatorColor: Colors.transparent,
            tabs: const [
              Tab(text: 'Trending'),
              Tab(text: 'New'),
              Tab(text: 'Collections'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPlaceholder(), // Trending (placeholder)
                _buildPlaceholder(), // New (placeholder)
                _buildCollectionsList(), // Collections
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.teal[200],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: 'BlockHub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'LifeX',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(child: Text('Placeholder for Trending/New'));
  }

  Widget _buildCollectionsList() {
    final List<Map<String, dynamic>> collections = [
      {
        'image': 'assets/images/collection1.png', // Replace with actual image paths
        'name': 'CryptoPunks',
        'floor': 'Floor: 65 ETH',
      },
      {
        'image': 'assets/images/collection2.png',
        'name': 'Bored Ape Yacht Club',
        'floor': 'Floor: 70 ETH',
      },
      {
        'image': 'assets/images/collection3.png',
        'name': 'Azuki',
        'floor': 'Floor: 15 ETH',
      },
      {
        'image': 'assets/images/collection4.png',
        'name': 'Moonbirds',
        'floor': 'Floor: 10 ETH',
      },
      {
        'image': 'assets/images/collection5.png',
        'name': 'Doodles',
        'floor': 'Floor: 12 ETH',
      },
      {
        'image': 'assets/images/collection6.png',
        'name': 'Mutant Ape Yacht Club',
        'floor': 'Floor: 18 ETH',
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8.0, // Horizontal spacing between cards
          runSpacing: 8.0, // Vertical spacing between rows
          children: List.generate(
            collections.length,
                (index) {
              final collection = collections[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NftDetailsPage(
                        imagePath: collection['image'],
                        name: collection['name'],
                        floor: collection['floor'],
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: (MediaQuery.of(context).size.width - 24) / 2, // Calculate width for two columns with spacing
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.asset(
                            collection['image']!,
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                collection['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                collection['floor']!,
                                style: TextStyle(
                                  color: Colors.teal[200],
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NftDetailsPage extends StatefulWidget {
  final String imagePath;
  final String name;
  final String floor;

  const NftDetailsPage({
    super.key,
    required this.imagePath,
    required this.name,
    required this.floor,
  });

  @override
  State<NftDetailsPage> createState() => _NftDetailsPageState();
}

class _NftDetailsPageState extends State<NftDetailsPage> {
  int _selectedIndex = 2; // BlockHub is selected (index 2)

  // Sample data for the line chart
  final List<FlSpot> chartData = [
    FlSpot(0, 1000),
    FlSpot(1, 1100),
    FlSpot(2, 1050),
    FlSpot(3, 1200),
    FlSpot(4, 1150),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('NFT Details', style: TextStyle(color: Colors.black87)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main NFT Image
            Image.asset(
              widget.imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            // Creator Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Creator',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('https://example.com/luna.jpg'), // Replace with actual avatar URL or asset
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Luna',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '@artisan_luna',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.teal[300],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Price History Section
                  const Text(
                    'Price History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Price Trend',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '\$1,250',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Text(
                    'Last 30 Days +15%',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Real Line Chart
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true, drawVerticalLine: true, getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey[300]!, strokeWidth: 0.5)),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 22,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 0:
                                    return const Text('Jan');
                                  case 1:
                                    return const Text('Feb');
                                  case 2:
                                    return const Text('Mar');
                                  case 3:
                                    return const Text('Apr');
                                  case 4:
                                    return const Text('May');
                                  default:
                                    return const Text('');
                                }
                              },
                            ),
                            axisNameWidget: const Text(''), // Empty axis name if not needed
                            axisNameSize: 0, // No extra space for axis name
                           // style: const TextStyle(color: Colors.black87, fontSize: 10), // Moved text style here
                          ),
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey[300]!, width: 1)),
                        minX: 0,
                        maxX: 4,
                        minY: 900,
                        maxY: 1300,
                        lineBarsData: [
                          LineChartBarData(
                            spots: chartData,
                            isCurved: true,
                            color: Colors.teal,
                            barWidth: 2,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                        lineTouchData: LineTouchData(enabled: false),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Additional Image
                 
                  // Buy/Bid Button (Fixed Position)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: const Text(
                        'Buy / Bid',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.teal[200],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: 'BlockHub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'LifeX',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
          ),
        ],
      ),
    );
  }
}