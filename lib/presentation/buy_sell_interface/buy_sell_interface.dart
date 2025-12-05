import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/action_button_widget.dart';
import './widgets/amount_input_widget.dart';
import './widgets/buy_sell_toggle_widget.dart';
import './widgets/fee_breakdown_widget.dart';
import './widgets/token_header_widget.dart';
import './widgets/transaction_preview_widget.dart';

class BuySellInterface extends StatefulWidget {
  const BuySellInterface({Key? key}) : super(key: key);

  @override
  State<BuySellInterface> createState() => _BuySellInterfaceState();
}

class _BuySellInterfaceState extends State<BuySellInterface>
    with SingleTickerProviderStateMixin {
  bool _isBuyMode = true;
  double _currentAmount = 0.0;
  String _selectedCurrency = 'USD';
  ButtonState _buttonState = ButtonState.enabled;
  bool _showBiometricAuth = false;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  // Mock data for selected token
  final Map<String, dynamic> _selectedToken = {
    "id": "bitcoin",
    "name": "Bitcoin",
    "symbol": "BTC",
    "current_price": 43250.75,
    "price_change_percentage_24h": 2.34,
    "image": "https://cryptologos.cc/logos/bitcoin-btc-logo.png",
  };

  // Mock user balance
  final double _userBalance = 5000.0; // USD balance

  // Mock fee data
  final double _networkFee = 12.50;
  final double _platformFee = 8.75;
  final double _gasPrice = 25.0;
  final int _estimatedGasUnits = 21000;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Start slide animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _onBuySellToggle(bool isBuy) {
    setState(() {
      _isBuyMode = isBuy;
      _buttonState = ButtonState.enabled;
    });

    // Haptic feedback
    HapticFeedback.selectionClick();
  }

  void _onAmountChanged(double amount) {
    setState(() {
      _currentAmount = amount;
      _buttonState = ButtonState.enabled;
    });
  }

  void _onCurrencyToggle(String currency) {
    setState(() {
      _selectedCurrency = currency;
    });

    // Haptic feedback
    HapticFeedback.selectionClick();
  }

  bool get _isValidTransaction {
    if (_currentAmount <= 0) return false;

    final totalCost = _selectedCurrency == 'USD'
        ? _currentAmount + _networkFee + _platformFee
        : (_currentAmount * _selectedToken['current_price']) +
            _networkFee +
            _platformFee;

    return _isBuyMode ? totalCost <= _userBalance : _currentAmount > 0;
  }

  String? get _validationMessage {
    if (_currentAmount <= 0) return null;

    final totalCost = _selectedCurrency == 'USD'
        ? _currentAmount + _networkFee + _platformFee
        : (_currentAmount * _selectedToken['current_price']) +
            _networkFee +
            _platformFee;

    if (_isBuyMode && totalCost > _userBalance) {
      return 'Insufficient balance';
    }

    if (_currentAmount < 10) {
      return 'Minimum transaction amount is \$10';
    }

    return null;
  }

  Future<void> _handleTransaction() async {
    if (!_isValidTransaction) return;

    // Haptic feedback
    HapticFeedback.mediumImpact();

    setState(() {
      _buttonState = ButtonState.loading;
    });

    // Show biometric authentication
    setState(() {
      _showBiometricAuth = true;
    });

    // Simulate biometric authentication
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _showBiometricAuth = false;
    });

    // Simulate transaction processing
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _buttonState = ButtonState.success;
    });

    // Success haptic feedback
    HapticFeedback.heavyImpact();

    // Navigate to success screen after delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.elevatedSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 15.w,
              height: 15.w,
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.successGreen,
                size: 8.w,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Transaction Successful!',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Your ${_isBuyMode ? 'purchase' : 'sale'} of ${_selectedToken['symbol']} has been completed successfully.',
              textAlign: TextAlign.center,
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(
                          context, '/crypto-transaction-history');
                    },
                    child: Text('View History'),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/crypto-trading-dashboard');
                    },
                    child: Text('Done'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.trueDarkBackground,
      body: Stack(
        children: [
          // Main Content
          SlideTransition(
            position: _slideAnimation,
            child: SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: AppTheme.elevatedSurface
                                  .withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: CustomIconWidget(
                              iconName: 'arrow_back',
                              color: AppTheme.textPrimary,
                              size: 24,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Buy & Sell',
                            textAlign: TextAlign.center,
                            style: AppTheme.darkTheme.textTheme.titleLarge
                                ?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w), // Balance the back button
                      ],
                    ),
                  ),

                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        children: [
                          // Token Header
                          TokenHeaderWidget(
                            tokenName: _selectedToken['name'],
                            tokenSymbol: _selectedToken['symbol'],
                            currentPrice: _selectedToken['current_price'],
                            priceChange24h:
                                _selectedToken['price_change_percentage_24h'],
                            tokenImage: _selectedToken['image'],
                          ),
                          SizedBox(height: 3.h),

                          // Buy/Sell Toggle
                          BuySellToggleWidget(
                            isBuyMode: _isBuyMode,
                            onToggle: _onBuySellToggle,
                          ),
                          SizedBox(height: 3.h),

                          // Amount Input
                          AmountInputWidget(
                            selectedToken: _selectedToken['symbol'],
                            tokenPrice: _selectedToken['current_price'],
                            isBuyMode: _isBuyMode,
                            onAmountChanged: _onAmountChanged,
                            onCurrencyToggle: _onCurrencyToggle,
                            currentCurrency: _selectedCurrency,
                            availableBalance: _userBalance,
                          ),
                          SizedBox(height: 3.h),

                          // Fee Breakdown
                          FeeBreakdownWidget(
                            networkFee: _networkFee,
                            platformFee: _platformFee,
                            gasPrice: _gasPrice,
                            estimatedGasUnits: _estimatedGasUnits,
                          ),
                          SizedBox(height: 3.h),

                          // Transaction Preview
                          TransactionPreviewWidget(
                            selectedToken: _selectedToken['symbol'],
                            amount: _currentAmount,
                            currency: _selectedCurrency,
                            tokenPrice: _selectedToken['current_price'],
                            isBuyMode: _isBuyMode,
                            networkFee: _networkFee,
                            platformFee: _platformFee,
                          ),
                          SizedBox(height: 3.h),

                          // Validation Message
                          if (_validationMessage != null)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(3.w),
                              margin: EdgeInsets.only(bottom: 3.h),
                              decoration: BoxDecoration(
                                color: AppTheme.errorRed.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      AppTheme.errorRed.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  CustomIconWidget(
                                    iconName: 'warning',
                                    color: AppTheme.errorRed,
                                    size: 20,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    _validationMessage!,
                                    style: AppTheme
                                        .darkTheme.textTheme.bodyMedium
                                        ?.copyWith(
                                      color: AppTheme.errorRed,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Action Button
                          ActionButtonWidget(
                            isBuyMode: _isBuyMode,
                            isEnabled: _isValidTransaction,
                            onPressed: _handleTransaction,
                            buttonState: _buttonState,
                          ),
                          SizedBox(height: 4.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Biometric Authentication Overlay
          if (_showBiometricAuth)
            Container(
              color: AppTheme.trueDarkBackground.withValues(alpha: 0.9),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: AppTheme.elevatedSurface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.primaryGold.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGold.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: CustomIconWidget(
                          iconName: 'fingerprint',
                          color: AppTheme.primaryGold,
                          size: 10.w,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Authenticate Transaction',
                        style:
                            AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Use your fingerprint or face ID to confirm this transaction',
                        textAlign: TextAlign.center,
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      SizedBox(
                        width: 6.w,
                        height: 6.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.primaryGold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}