import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/currency_card_widget.dart';
import './widgets/exchange_rate_widget.dart';
import './widgets/payment_method_card_widget.dart';

class DigitalWallet extends StatefulWidget {
  const DigitalWallet({Key? key}) : super(key: key);

  @override
  State<DigitalWallet> createState() => _DigitalWalletState();
}

class _DigitalWalletState extends State<DigitalWallet> {
  String selectedCurrency = 'USD';
  bool isRefreshing = false;
  DateTime lastUpdated = DateTime.now();
  List<String> selectedCurrencies = [];
  bool isBulkSelectionMode = false;

  final List<Map<String, dynamic>> currencies = [
    {
      "code": "USD",
      "name": "US Dollar",
      "balance": 2847.50,
      "flag": "🇺🇸",
      "change24h": 0.0,
      "changePercent": 0.0,
      "rate": 1.0,
      "isPrimary": true,
    },
    {
      "code": "EUR",
      "name": "Euro",
      "balance": 1250.75,
      "flag": "🇪🇺",
      "change24h": -15.30,
      "changePercent": -1.21,
      "rate": 0.85,
      "isPrimary": false,
    },
    {
      "code": "GBP",
      "name": "British Pound",
      "balance": 890.25,
      "flag": "🇬🇧",
      "change24h": 8.45,
      "changePercent": 0.96,
      "rate": 0.73,
      "isPrimary": false,
    },
  ];

  final List<Map<String, dynamic>> paymentMethods = [
    {
      "id": 1,
      "type": "card",
      "provider": "Visa",
      "lastFour": "4532",
      "expiryMonth": 12,
      "expiryYear": 2026,
      "isDefault": true,
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/5/5e/Visa_Inc._logo.svg",
    },
    {
      "id": 2,
      "type": "card",
      "provider": "Mastercard",
      "lastFour": "8901",
      "expiryMonth": 8,
      "expiryYear": 2025,
      "isDefault": false,
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/2/2a/Mastercard-logo.svg",
    },
    {
      "id": 3,
      "type": "bank",
      "provider": "Chase Bank",
      "lastFour": "7654",
      "accountType": "Checking",
      "isDefault": false,
      "logo":
          "https://logos-world.net/wp-content/uploads/2021/02/Chase-Logo.png",
    },
  ];

  final List<Map<String, dynamic>> trendingCurrencies = [
    {
      "code": "JPY",
      "name": "Japanese Yen",
      "flag": "🇯🇵",
      "rate": 110.25,
      "change": 2.1
    },
    {
      "code": "CAD",
      "name": "Canadian Dollar",
      "flag": "🇨🇦",
      "rate": 1.25,
      "change": -0.8
    },
    {
      "code": "AUD",
      "name": "Australian Dollar",
      "flag": "🇦🇺",
      "rate": 1.35,
      "change": 1.5
    },
  ];

  double get totalWalletValue {
    return (currencies as List).fold(0.0, (sum, currency) {
      final balance = (currency as Map<String, dynamic>)["balance"] as double;
      final rate = (currency)["rate"] as double;
      return sum + (balance * rate);
    });
  }

  Future<void> _refreshRates() async {
    setState(() {
      isRefreshing = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isRefreshing = false;
      lastUpdated = DateTime.now();
    });
  }

  void _toggleBulkSelection() {
    setState(() {
      isBulkSelectionMode = !isBulkSelectionMode;
      if (!isBulkSelectionMode) {
        selectedCurrencies.clear();
      }
    });
  }

  void _toggleCurrencySelection(String currencyCode) {
    setState(() {
      if (selectedCurrencies.contains(currencyCode)) {
        selectedCurrencies.remove(currencyCode);
      } else {
        selectedCurrencies.add(currencyCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: RefreshIndicator(
        onRefresh: _refreshRates,
        color: AppTheme.accentGold,
        backgroundColor: AppTheme.secondaryDark,
        child: CustomScrollView(
          slivers: [
            _buildStickyHeader(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCurrencySection(),
                  SizedBox(height: 3.h),
                  _buildPaymentMethodsSection(),
                  SizedBox(height: 3.h),
                  _buildExchangeRatesSection(),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildStickyHeader() {
    return SliverAppBar(
      expandedHeight: 20.h,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.primaryDark,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Wallet Value',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  Text(
                    '\$${totalWalletValue.toStringAsFixed(2)}',
                    style:
                        AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: AppTheme.successGreen.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '+2.4%',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.successGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              _buildCurrencySelector(),
            ],
          ),
        ),
      ),
      actions: [
        if (isBulkSelectionMode)
          TextButton(
            onPressed: _toggleBulkSelection,
            child: Text(
              'Cancel',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.accentGold,
              ),
            ),
          ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/transaction-history');
          },
          icon: CustomIconWidget(
            iconName: 'history',
            color: AppTheme.textPrimary,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderGray, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCurrency,
          dropdownColor: AppTheme.secondaryDark,
          icon: CustomIconWidget(
            iconName: 'keyboard_arrow_down',
            color: AppTheme.textSecondary,
            size: 20,
          ),
          items: (currencies as List).map<DropdownMenuItem<String>>((currency) {
            final currencyMap = currency as Map<String, dynamic>;
            return DropdownMenuItem<String>(
              value: currencyMap["code"] as String,
              child: Row(
                children: [
                  Text(
                    currencyMap["flag"] as String,
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    currencyMap["code"] as String,
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedCurrency = newValue;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildCurrencySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Currencies',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
              if (selectedCurrencies.isNotEmpty)
                ElevatedButton(
                  onPressed: () {
                    // Handle portfolio rebalancing
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentGold,
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  ),
                  child: Text(
                    'Rebalance',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.primaryDark,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 25.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: currencies.length,
            itemBuilder: (context, index) {
              final currency = currencies[index];
              return Padding(
                padding: EdgeInsets.only(right: 3.w),
                child: CurrencyCardWidget(
                  currency: currency,
                  isSelected: selectedCurrencies.contains(currency["code"]),
                  isBulkSelectionMode: isBulkSelectionMode,
                  onTap: () {
                    if (isBulkSelectionMode) {
                      _toggleCurrencySelection(currency["code"] as String);
                    }
                  },
                  onLongPress: () {
                    if (!isBulkSelectionMode) {
                      _toggleBulkSelection();
                      _toggleCurrencySelection(currency["code"] as String);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment Methods',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle add payment method
                },
                child: Text(
                  'Add New',
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.accentGold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          itemCount: paymentMethods.length,
          itemBuilder: (context, index) {
            final paymentMethod = paymentMethods[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: PaymentMethodCardWidget(
                paymentMethod: paymentMethod,
                onTap: () {
                  // Handle payment method details
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildExchangeRatesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Currencies',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                'Last updated: ${lastUpdated.hour.toString().padLeft(2, '0')}:${lastUpdated.minute.toString().padLeft(2, '0')}',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          itemCount: trendingCurrencies.length,
          itemBuilder: (context, index) {
            final currency = trendingCurrencies[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: ExchangeRateWidget(
                currency: currency,
                onTap: () {
                  // Handle add currency
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // Handle add payment method with card scanning
      },
      backgroundColor: AppTheme.accentGold,
      child: CustomIconWidget(
        iconName: 'add',
        color: AppTheme.primaryDark,
        size: 24,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppTheme.secondaryDark,
      selectedItemColor: AppTheme.accentGold,
      unselectedItemColor: AppTheme.textSecondary,
      currentIndex: 1, // Wallet tab active
      items: [
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'home',
            color: AppTheme.textSecondary,
            size: 24,
          ),
          activeIcon: CustomIconWidget(
            iconName: 'home',
            color: AppTheme.accentGold,
            size: 24,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'account_balance_wallet',
            color: AppTheme.accentGold,
            size: 24,
          ),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'currency_bitcoin',
            color: AppTheme.textSecondary,
            size: 24,
          ),
          activeIcon: CustomIconWidget(
            iconName: 'currency_bitcoin',
            color: AppTheme.accentGold,
            size: 24,
          ),
          label: 'Crypto',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'palette',
            color: AppTheme.textSecondary,
            size: 24,
          ),
          activeIcon: CustomIconWidget(
            iconName: 'palette',
            color: AppTheme.accentGold,
            size: 24,
          ),
          label: 'NFT',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'explore',
            color: AppTheme.textSecondary,
            size: 24,
          ),
          activeIcon: CustomIconWidget(
            iconName: 'explore',
            color: AppTheme.accentGold,
            size: 24,
          ),
          label: 'LifeX',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            // Navigate to home
            break;
          case 1:
            // Already on wallet
            break;
          case 2:
            Navigator.pushNamed(context, '/cryptocurrency-trading');
            break;
          case 3:
            Navigator.pushNamed(context, '/nft-marketplace');
            break;
          case 4:
            Navigator.pushNamed(context, '/life-x-ecosystem');
            break;
        }
      },
    );
  }
}
