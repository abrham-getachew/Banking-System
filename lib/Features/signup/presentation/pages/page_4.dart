import 'package:chronos/Features/signup/presentation/pages/page_5.dart';
import 'package:flutter/material.dart';

class CountrySelectionPage extends StatefulWidget {
  const CountrySelectionPage({super.key});

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  String selectedCountry = "United Kingdom";

  final List<dynamic> countries = [
    {"name": "United Kingdom", "flag": "🇬🇧"},
    {"name": "France", "flag": "🇫🇷"},
    {"name": "United States", "flag": "🇺🇸"},
    {"name": "India", "flag": "🇮🇳"},
    {"name": "Aland Islands", "flag": "🇦🇽"},
    {"name": "Ethiopia", "flag": "🇪🇹"},
    {"name": "Germany", "flag": "🇩🇪"},
    {"name": "Canada", "flag": "🇨🇦"},
    {"name": "Japan", "flag": "🇯🇵"},
    {"name": "Brazil", "flag": "🇧🇷"},
    {"name": "Australia", "flag": "🇦🇺"},
    {"name": "Italy", "flag": "🇮🇹"},
    {"name": "Spain", "flag": "🇪🇸"},
    {"name": "South Africa", "flag": "🇿🇦"},
    {"name": "China", "flag": "🇨🇳"},
  ];


  void _openCountryPicker() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CountryPickerModal(
          countries: countries,
          selectedCountry: selectedCountry,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        selectedCountry = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sh * 0.02),

              Text(
                "Country of residence",
                style: TextStyle(
                  fontSize: sw * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: sh * 0.015),

              Text(
                "The terms and services which apply to you will depend on your country of residence.",
                style: TextStyle(
                  fontSize: sw * 0.045,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),

              SizedBox(height: sh * 0.04),

              Text(
                "Country",
                style: TextStyle(
                  fontSize: sw * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: sh * 0.01),

              GestureDetector(
                onTap: _openCountryPicker,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.018),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedCountry, style: TextStyle(fontSize: sw * 0.045)),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: sh * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NameAsInIDPage()),
                      );
                    }
                  },
                  child: Text(
                    "Sign up securely",
                    style: TextStyle(fontSize: sw * 0.05),
                  ),
                ),
              ),

              SizedBox(height: sh * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryPickerModal extends StatefulWidget {
  final List<dynamic> countries;
  final String selectedCountry;

  const CountryPickerModal({
    super.key,
    required this.countries,
    required this.selectedCountry,
  });

  @override
  State<CountryPickerModal> createState() => _CountryPickerModalState();
}

class _CountryPickerModalState extends State<CountryPickerModal> {
  late List<dynamic> filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCountries = widget.countries;
    _searchController.addListener(_filterCountries);
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCountries = widget.countries.where((country) {
        if (country is String) {
          return country.toLowerCase().contains(query);
        } else if (country is Map<String, String>) {
          return country['name']!.toLowerCase().contains(query);
        }
        return false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110), // taller for more space
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 8, right: 8, top: 40, bottom: 8), // pushed further down
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: "Search country",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20, // bigger cancel text
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredCountries.length,
        itemBuilder: (context, index) {
          final country = filteredCountries[index];
          String name;
          String? flag;

          if (country is String) {
            name = country;
            flag = null;
          } else {
            name = country['name']!;
            flag = country['flag'];
          }

          return ListTile(
            leading: flag != null
                ? CircleAvatar(
              radius: sw * 0.07, // bigger circle
              backgroundColor: Colors.grey[200],
              child: Text(
                flag,
                style: TextStyle(fontSize: sw * 0.09), // bigger flag
              ),
            )
                : null,
            title: Text(
              name,
              style: TextStyle(
                fontSize: sw * 0.055, // bigger country name
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () => Navigator.pop(context, name),
          );
        },
      ),
    );
  }
}
