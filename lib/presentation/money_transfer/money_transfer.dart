import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/amount_input_widget.dart';
import './widgets/qr_scanner_overlay_widget.dart';
import './widgets/recipient_selection_widget.dart';
import './widgets/review_section_widget.dart';
import './widgets/transfer_method_widget.dart';

class MoneyTransfer extends StatefulWidget {
  const MoneyTransfer({super.key});

  @override
  State<MoneyTransfer> createState() => _MoneyTransferState();
}

class _MoneyTransferState extends State<MoneyTransfer>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _showQRScanner = false;

  // Form data
  Map<String, dynamic>? _selectedRecipient;
  double _amount = 0.0;
  String _selectedCurrency = 'USD';
  String _selectedAccount = '';
  String _transferMethod = 'Standard';
  String _message = '';
  DateTime? _scheduledDate;

  final List<String> _stepTitles = [
    'Select Recipient',
    'Enter Amount',
    'Transfer Method',
    'Review & Send'
  ];

  // Mock data
  final List<Map<String, dynamic>> _recentContacts = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 123-4567",
      "avatar":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "lastTransfer": DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      "id": "2",
      "name": "Michael Chen",
      "email": "michael.chen@email.com",
      "phone": "+1 (555) 987-6543",
      "avatar":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "lastTransfer": DateTime.now().subtract(const Duration(days: 5)),
    },
    {
      "id": "3",
      "name": "Emma Rodriguez",
      "email": "emma.rodriguez@email.com",
      "phone": "+1 (555) 456-7890",
      "avatar":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "lastTransfer": DateTime.now().subtract(const Duration(days: 7)),
    },
  ];

  final List<Map<String, dynamic>> _accounts = [
    {
      "id": "acc_1",
      "name": "Chronos Checking",
      "balance": 2450.75,
      "currency": "USD",
      "type": "checking",
      "accountNumber": "****1234",
    },
    {
      "id": "acc_2",
      "name": "Savings Account",
      "balance": 15680.50,
      "currency": "USD",
      "type": "savings",
      "accountNumber": "****5678",
    },
    {
      "id": "acc_3",
      "name": "Investment Account",
      "balance": 8920.25,
      "currency": "USD",
      "type": "investment",
      "accountNumber": "****9012",
    },
  ];

  final List<Map<String, dynamic>> _transferMethods = [
    {
      "id": "instant",
      "name": "Instant",
      "description": "Arrives within minutes",
      "fee": 2.99,
      "duration": "1-5 minutes",
      "icon": "flash_on",
    },
    {
      "id": "standard",
      "name": "Standard",
      "description": "1-2 business days",
      "fee": 0.0,
      "duration": "1-2 business days",
      "icon": "schedule",
    },
    {
      "id": "scheduled",
      "name": "Scheduled",
      "description": "Send on a future date",
      "fee": 0.0,
      "duration": "Custom date",
      "icon": "event",
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedAccount = _accounts.first['id'];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _stepTitles.length - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onRecipientSelected(Map<String, dynamic> recipient) {
    setState(() {
      _selectedRecipient = recipient;
    });
    _nextStep();
  }

  void _onAmountChanged(double amount, String currency) {
    setState(() {
      _amount = amount;
      _selectedCurrency = currency;
    });
  }

  void _onTransferMethodChanged(String method, DateTime? scheduledDate) {
    setState(() {
      _transferMethod = method;
      _scheduledDate = scheduledDate;
    });
  }

  void _onMessageChanged(String message) {
    setState(() {
      _message = message;
    });
  }

  void _toggleQRScanner() {
    setState(() {
      _showQRScanner = !_showQRScanner;
    });
  }

  void _onQRScanned(String data) {
    // Handle QR code data
    setState(() {
      _showQRScanner = false;
    });

    // Parse QR data and populate recipient
    try {
      // Mock QR parsing - in real app would parse payment QR codes
      final Map<String, dynamic> qrRecipient = {
        "id": "qr_${DateTime.now().millisecondsSinceEpoch}",
        "name": "QR Contact",
        "email": data.contains('@') ? data : "qr.contact@email.com",
        "phone": "+1 (555) 000-0000",
        "avatar":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
        "isQRContact": true,
      };

      _onRecipientSelected(qrRecipient);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid QR code format'),
          backgroundColor: AppTheme.errorRed,
        ),
      );
    }
  }

  void _sendMoney() async {
    if (_selectedRecipient == null || _amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please complete all required fields'),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceModal,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AppTheme.accentGold,
              ),
              SizedBox(height: 2.h),
              Text(
                'Processing Transfer...',
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );

    // Simulate processing
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).pop(); // Close loading dialog

      // Show success
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceModal,
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
                iconName: 'check',
                color: AppTheme.successGreen,
                size: 8.w,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Transfer Successful!',
              style: AppTheme.darkTheme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              '\$${_amount.toStringAsFixed(2)} sent to ${_selectedRecipient!['name']}',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    'Transaction ID',
                    style: AppTheme.darkTheme.textTheme.bodySmall,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'TXN${DateTime.now().millisecondsSinceEpoch}',
                    style: AppTheme.getMonospaceStyle(
                      isLight: false,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text('Done'),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Share functionality
                      HapticFeedback.lightImpact();
                    },
                    child: Text('Share'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool get _canProceed {
    switch (_currentStep) {
      case 0:
        return _selectedRecipient != null;
      case 1:
        return _amount > 0;
      case 2:
        return _transferMethod.isNotEmpty;
      case 3:
        return true;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryDark,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 6.w,
          ),
        ),
        title: Text(
          'Send Money',
          style: AppTheme.darkTheme.textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: _toggleQRScanner,
            icon: CustomIconWidget(
              iconName: 'qr_code_scanner',
              color: AppTheme.accentGold,
              size: 6.w,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Progress Indicator
              Container(
                padding: EdgeInsets.all(4.w),
                child: Row(
                  children: List.generate(_stepTitles.length, (index) {
                    final isActive = index <= _currentStep;
                    final isCompleted = index < _currentStep;

                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 0.5.h,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppTheme.accentGold
                                    : AppTheme.borderGray,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          if (index < _stepTitles.length - 1)
                            SizedBox(width: 2.w),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              // Step Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    Text(
                      'Step ${_currentStep + 1} of ${_stepTitles.length}',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Spacer(),
                    Text(
                      _stepTitles[_currentStep],
                      style: AppTheme.darkTheme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2.h),

              // Page Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    RecipientSelectionWidget(
                      recentContacts: _recentContacts,
                      onRecipientSelected: _onRecipientSelected,
                      selectedRecipient: _selectedRecipient,
                    ),
                    AmountInputWidget(
                      amount: _amount,
                      currency: _selectedCurrency,
                      accounts: _accounts,
                      selectedAccount: _selectedAccount,
                      onAmountChanged: _onAmountChanged,
                      onAccountChanged: (accountId) {
                        setState(() {
                          _selectedAccount = accountId;
                        });
                      },
                    ),
                    TransferMethodWidget(
                      methods: _transferMethods,
                      selectedMethod: _transferMethod,
                      scheduledDate: _scheduledDate,
                      message: _message,
                      onMethodChanged: _onTransferMethodChanged,
                      onMessageChanged: _onMessageChanged,
                    ),
                    ReviewSectionWidget(
                      recipient: _selectedRecipient,
                      amount: _amount,
                      currency: _selectedCurrency,
                      account: _accounts.firstWhere(
                        (acc) => acc['id'] == _selectedAccount,
                      ),
                      transferMethod: _transferMethods.firstWhere(
                        (method) => method['id'] == _transferMethod,
                      ),
                      message: _message,
                      scheduledDate: _scheduledDate,
                    ),
                  ],
                ),
              ),

              // Bottom Actions
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryDark,
                  border: Border(
                    top: BorderSide(
                      color: AppTheme.borderGray,
                      width: 1,
                    ),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      if (_currentStep > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _previousStep,
                            child: Text('Back'),
                          ),
                        ),
                      if (_currentStep > 0) SizedBox(width: 4.w),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _canProceed
                              ? (_currentStep == _stepTitles.length - 1
                                  ? _sendMoney
                                  : _nextStep)
                              : null,
                          child: Text(
                            _currentStep == _stepTitles.length - 1
                                ? 'Send Money'
                                : 'Continue',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // QR Scanner Overlay
          if (_showQRScanner)
            QRScannerOverlayWidget(
              onQRScanned: _onQRScanned,
              onClose: _toggleQRScanner,
            ),
        ],
      ),
    );
  }
}
