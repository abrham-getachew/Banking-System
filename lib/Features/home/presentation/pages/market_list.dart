import 'package:chronos/Features/home/presentation/pages/token_detail.dart';
import 'package:flutter/material.dart';
import 'nav_page.dart';

class Marketlist extends StatefulWidget {
  const Marketlist({super.key});

  @override
  State<Marketlist> createState() => _BlockHubHomePageState();
}

class _BlockHubHomePageState extends State<Marketlist> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 2; // BlockHub is selected (index 2)
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredCryptos = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    filteredCryptos = _getAllCryptos(); // Initialize with all cryptos
    _searchController.addListener(_filterCryptos); // Listen to search input changes
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getAllCryptos() {
    return [
      {
        'icon': Icons.currency_bitcoin,
        'color': Colors.orange,
        'name': 'Bitcoin',
        'price': '\$1,234.56',
        'change': '+2.3%',
        'changeColor': Colors.green,
      },
      {
        'icon': Icons.change_history,
        'color': Colors.black,
        'name': 'Ethereum',
        'price': '\$123.45',
        'change': '-1.2%',
        'changeColor': Colors.red,
      },
      {
        'icon': Icons.circle,
        'color': Colors.black,
        'name': 'Cardano',
        'price': '\$12.34',
        'change': '+0.5%',
        'changeColor': Colors.green,
      },
      {
        'icon': Icons.square,
        'color': Colors.orange[100],
        'name': 'Solana',
        'price': '\$123',
        'change': '-0.8%',
        'changeColor': Colors.red,
      },
      {
        'icon': Icons.circle_outlined,
        'color': Colors.teal,
        'name': 'Ripple',
        'price': '\$0.12',
        'change': '+1.5%',
        'changeColor': Colors.green,
      },
      {
        'icon': Icons.pets,
        'color': Colors.green[200],
        'name': 'Dogecoin',
        'price': '\$0.01',
        'change': '-0.3%',
        'changeColor': Colors.red,
      },
    ];
  }

  void _filterCryptos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCryptos = _getAllCryptos().where((crypto) {
        return crypto['name'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlockHub'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tokens...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.blueGrey[50],
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.transparent,
            tabs: const [
              Tab(text: 'Top Gainers'),
              Tab(text: 'Losers'),
              Tab(text: 'New Listings'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCryptoList(), // Top Gainers
                _buildCryptoList(), // Losers (placeholder, same for demo)
                _buildCryptoList(), // New Listings (placeholder, same for demo)
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 2,),
    );
  }

  Widget _buildCryptoList() {
    return ListView.builder(
      itemCount: filteredCryptos.length,
      itemBuilder: (context, index) {
        final crypto = filteredCryptos[index];
        bool isClickable = crypto['name'] == 'Bitcoin' || crypto['name'] == 'Ethereum';
        return GestureDetector(
          onTap: isClickable
              ? () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CryptoScreen(), // Assuming MarketListPage is defined
                ),
              );
            }// Action for Bitcoin and Ethereum click
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Clicked on ${crypto['name']}')),
            );
          }
              : null,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: crypto['color'],
              child: Icon(crypto['icon'], color: Colors.white),
            ),
            title: Text(crypto['name']),
            subtitle: Text(crypto['price']),
            trailing: Text(
              crypto['change'],
              style: TextStyle(color: crypto['changeColor']),
            ),
            tileColor: isClickable ? Colors.grey[200] : null, // Visual cue for clickable items
          ),
        );
      },
    );
  }
}