import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/advanced_settings_widget.dart';
import './widgets/amount_input_widget.dart';
import './widgets/rate_comparison_widget.dart';
import './widgets/swap_button_widget.dart';
import './widgets/token_selection_modal.dart';
import './widgets/token_selector_widget.dart';
import './widgets/transaction_preview_widget.dart';

class TokenExchange extends StatefulWidget {
  const TokenExchange({Key? key}) : super(key: key);

  @override
  State<TokenExchange> createState() => _TokenExchangeState();
}

class _TokenExchangeState extends State<TokenExchange>
    with TickerProviderStateMixin {
  final TextEditingController _fromAmountController = TextEditingController();
  final TextEditingController _toAmountController = TextEditingController();

  // Animation controllers
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;

  // Token data
  Map<String, dynamic> _fromToken = {
    "symbol": "ETH",
    "name": "Ethereum",
    "icon": "https://cryptologos.cc/logos/ethereum-eth-logo.png",
    "balance": "1.23456789",
    "usdValue": "\$2,345.67",
  };

  Map<String, dynamic> _toToken = {
    "symbol": "USDT",
    "name": "Tether USD",
    "icon": "https://cryptologos.cc/logos/tether-usdt-logo.png",
    "balance": "1,234.56",
    "usdValue": "\$1,234.56",
  };

  // Exchange data
  double _slippageTolerance = 0.5;
  int _transactionDeadline = 20;
  String _gasFee = "\$12.34 (0.0045 ETH)";
  bool _isRateLoading = false;
  String _exchangeRate = "1 ETH = 2,345.67 USDT";
  String _percentageDifference = "+0.12%";
  bool _isRatePositive = true;

  // Transaction preview data
  String _inputAmount = "0.0";
  String _outputAmount = "0.0";
  String _minimumReceived = "0.0";
  String _priceImpact = "0.00%";
  String _totalFees = "\$12.34";
  bool _isPriceImpactHigh = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _fromAmountController.addListener(_calculateExchange);
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    _fromAmountController.dispose();
    _toAmountController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideAnimationController,
      curve: Curves.easeOut,
    ));
    _slideAnimationController.forward();
  }

  void _calculateExchange() {
    final fromAmount = double.tryParse(_fromAmountController.text) ?? 0.0;
    if (fromAmount > 0) {
      setState(() {
        _isRateLoading = true;
      });

      // Simulate rate fetching
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          final exchangeRate = 2345.67; // ETH to USDT rate
          final outputAmount = fromAmount * exchangeRate;
          final slippageAmount = outputAmount * (_slippageTolerance / 100);
          final minimumReceived = outputAmount - slippageAmount;
          final priceImpact = (fromAmount * 0.1); // Simulate price impact
          final isPriceImpactHigh = priceImpact > 5.0;

          setState(() {
            _isRateLoading = false;
            _inputAmount =
                "${fromAmount.toStringAsFixed(6)} ${_fromToken['symbol']}";
            _outputAmount =
                "${outputAmount.toStringAsFixed(2)} ${_toToken['symbol']}";
            _minimumReceived =
                "${minimumReceived.toStringAsFixed(2)} ${_toToken['symbol']}";
            _priceImpact = "${priceImpact.toStringAsFixed(2)}%";
            _isPriceImpactHigh = isPriceImpactHigh;
            _toAmountController.text = outputAmount.toStringAsFixed(6);
          });
        }
      });
    } else {
      setState(() {
        _inputAmount = "0.0";
        _outputAmount = "0.0";
        _minimumReceived = "0.0";
        _priceImpact = "0.00%";
        _isPriceImpactHigh = false;
        _toAmountController.clear();
      });
    }
  }

  void _swapTokens() {
    HapticFeedback.lightImpact();
    setState(() {
      final tempToken = _fromToken;
      _fromToken = _toToken;
      _toToken = tempToken;

      final tempAmount = _fromAmountController.text;
      _fromAmountController.text = _toAmountController.text;
      _toAmountController.text = tempAmount;
    });
    _calculateExchange();
  }

  void _showTokenSelectionModal(bool isFromToken) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TokenSelectionModal(
        onTokenSelected: (token) {
          setState(() {
            if (isFromToken) {
              _fromToken = token;
            } else {
              _toToken = token;
            }
          });
          _calculateExchange();
        },
      ),
    );
  }

  void _showConfirmationModal() {
    if (_fromAmountController.text.isEmpty ||
        double.tryParse(_fromAmountController.text) == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter an amount to swap'),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.elevatedSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Confirm Swap',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You are about to swap $_inputAmount for $_outputAmount',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'This action requires biometric authentication.',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processSwap();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGold,
              foregroundColor: AppTheme.trueDarkBackground,
            ),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _processSwap() {
    // Simulate transaction processing
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
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
            ),
            SizedBox(height: 3.h),
            Text(
              'Processing swap...',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
      _showSuccessModal();
    });
  }

  void _showSuccessModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.elevatedSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'check',
                color: AppTheme.successGreen,
                size: 6.w,
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              'Swap Successful',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your swap has been completed successfully.',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Transaction Hash:',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              '0x1234...5678',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.primaryGold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/crypto-transaction-history');
            },
            child: Text(
              'View History',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGold,
              foregroundColor: AppTheme.trueDarkBackground,
            ),
            child: Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.trueDarkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.trueDarkBackground,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.elevatedSurface.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomIconWidget(
              iconName: 'arrow_back',
              color: AppTheme.textPrimary,
              size: 6.w,
            ),
          ),
        ),
        title: Text(
          'Token Exchange',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, '/crypto-transaction-history'),
            child: Container(
              margin: EdgeInsets.all(2.w),
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.elevatedSurface.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomIconWidget(
                iconName: 'history',
                color: AppTheme.textPrimary,
                size: 6.w,
              ),
            ),
          ),
        ],
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              // From Token Section
              TokenSelectorWidget(
                tokenSymbol: _fromToken['symbol'],
                tokenName: _fromToken['name'],
                tokenIcon: _fromToken['icon'],
                balance: _fromToken['balance'],
                isFromToken: true,
                onTap: () => _showTokenSelectionModal(true),
              ),
              SizedBox(height: 2.h),

              // From Amount Input
              AmountInputWidget(
                controller: _fromAmountController,
                label: 'You Pay',
                tokenSymbol: _fromToken['symbol'],
                usdValue: _fromToken['usdValue'],
                onChanged: (value) => _calculateExchange(),
              ),
              SizedBox(height: 3.h),

              // Swap Button
              Center(
                child: SwapButtonWidget(
                  onTap: _swapTokens,
                ),
              ),
              SizedBox(height: 3.h),

              // To Token Section
              TokenSelectorWidget(
                tokenSymbol: _toToken['symbol'],
                tokenName: _toToken['name'],
                tokenIcon: _toToken['icon'],
                balance: _toToken['balance'],
                isFromToken: false,
                onTap: () => _showTokenSelectionModal(false),
              ),
              SizedBox(height: 2.h),

              // To Amount Input
              AmountInputWidget(
                controller: _toAmountController,
                label: 'You Receive',
                tokenSymbol: _toToken['symbol'],
                usdValue: _toToken['usdValue'],
                isReadOnly: true,
              ),
              SizedBox(height: 4.h),

              // Rate Comparison
              RateComparisonWidget(
                exchangeRate: _exchangeRate,
                percentageDifference: _percentageDifference,
                isPositive: _isRatePositive,
                isLoading: _isRateLoading,
              ),
              SizedBox(height: 3.h),

              // Advanced Settings
              AdvancedSettingsWidget(
                slippageTolerance: _slippageTolerance,
                transactionDeadline: _transactionDeadline,
                gasFee: _gasFee,
                onSlippageChanged: (value) {
                  setState(() {
                    _slippageTolerance = value;
                  });
                  _calculateExchange();
                },
                onDeadlineChanged: (value) {
                  setState(() {
                    _transactionDeadline = value;
                  });
                },
                onGasFeeCustomize: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gas fee customization coming soon'),
                      backgroundColor: AppTheme.infoBlue,
                    ),
                  );
                },
              ),
              SizedBox(height: 3.h),

              // Transaction Preview
              if (_fromAmountController.text.isNotEmpty &&
                  double.tryParse(_fromAmountController.text) != null &&
                  double.tryParse(_fromAmountController.text)! > 0) ...[
                TransactionPreviewWidget(
                  inputAmount: _inputAmount,
                  outputAmount: _outputAmount,
                  minimumReceived: _minimumReceived,
                  priceImpact: _priceImpact,
                  totalFees: _totalFees,
                  isPriceImpactHigh: _isPriceImpactHigh,
                ),
                SizedBox(height: 4.h),
              ],

              // Review Swap Button
              SizedBox(
                width: double.infinity,
                height: 7.h,
                child: ElevatedButton(
                  onPressed: _showConfirmationModal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGold,
                    foregroundColor: AppTheme.trueDarkBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Review Swap',
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.trueDarkBackground,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),

              // Quick Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/buy-sell-interface'),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: AppTheme.primaryGold.withValues(alpha: 0.6)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                      ),
                      child: Text(
                        'Buy/Sell',
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.primaryGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/token-detail-view'),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: AppTheme.primaryGold.withValues(alpha: 0.6)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                      ),
                      child: Text(
                        'Token Details',
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.primaryGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
