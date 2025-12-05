import 'package:chronos/Features/signup/presentation/pages/page_8.dart';
import 'package:flutter/material.dart';

class PostcodePage extends StatefulWidget {
  const PostcodePage({super.key});

  @override
  State<PostcodePage> createState() => _PostcodePageState();
}

class _PostcodePageState extends State<PostcodePage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _allAddresses = [
    "1 Bush Loan Rd, Edinburgh",
    "3 Bush Loan Rd, Edinburgh",
    "5 Bush Loan Rd, Edinburgh",
    "7 Bush Loan Rd, Edinburgh",
    "9 Bush Loan Rd, Edinburgh",
    "11 Bush Loan Rd, Edinburgh",
    "15 Bush Loan Rd, Edinburgh",
    "21 High Street, London",
    "42 Oxford Street, London",
    "10 Downing Street, London",
    "221B Baker Street, London",
    "50 George Square, Edinburgh",
    "100 Princes Street, Edinburgh",
    "77 Kings Road, Brighton",
    "12 Castle Street, Cambridge",
    "88 Queen Street, Glasgow",
    "5 Market Street, York",
    "33 Church Lane, Manchester",
    "19 Park Avenue, Leeds",
    "60 Victoria Road, Birmingham",
  ];

  List<String> _filteredAddresses = [];
  String? _selectedAddress;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterAddresses);
  }

  void _filterAddresses() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _selectedAddress = null; // reset selection when typing
      if (query.isEmpty) {
        _filteredAddresses.clear();
      } else {
        _filteredAddresses = _allAddresses
            .where((address) => address.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.02, vertical: sh * 0.005),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: sh * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Home address postcode",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: sw * 0.03),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            // Address list or placeholder
            Expanded(
              child: _filteredAddresses.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.extension, size: 40, color: Colors.grey[400]),
                    const SizedBox(height: 8),
                    Text(
                      "Start typing to see your results",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              )
                  : ListView.separated(
                itemCount: _filteredAddresses.length,
                separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey[300]),
                itemBuilder: (context, index) {
                  final address = _filteredAddresses[index];
                  final isSelected = _selectedAddress == address;
                  return ListTile(
                    title: Text(
                      address,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? Colors.blue : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedAddress = address;
                      });
                    },
                  );
                },
              ),
            ),

            // Continue button
            Padding(
              padding: EdgeInsets.all(sw * 0.05),
              child: SizedBox(
                width: double.infinity,
                height: sh * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedAddress != null ? Colors.blue : Colors.grey[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _selectedAddress != null
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PageEight()),
                    );
                  }
                      : null,
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: sw * 0.05),
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
