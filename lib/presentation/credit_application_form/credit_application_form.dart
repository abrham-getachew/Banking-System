import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/employment_details_section.dart';
import './widgets/form_action_buttons.dart';
import './widgets/form_progress_indicator.dart';
import './widgets/identity_verification_section.dart';
import './widgets/personal_information_section.dart';

class CreditApplicationForm extends StatefulWidget {
  const CreditApplicationForm({super.key});

  @override
  State<CreditApplicationForm> createState() => _CreditApplicationFormState();
}

class _CreditApplicationFormState extends State<CreditApplicationForm> {
  final ScrollController _scrollController = ScrollController();
  bool _isSubmitting = false;

  // Form data
  Map<String, dynamic> _personalData = {
    'fullName': 'John Michael Smith',
    'firstName': 'John',
    'lastName': 'Smith',
    'email': 'john.smith@chronos.com',
    'phone': '+1 (555) 123-4567',
    'dateOfBirth': '03/15/1990',
    'ssn': '',
    'address': '123 Main Street, Apt 4B',
    'city': 'New York',
    'state': 'NY',
    'zipCode': '10001',
  };

  Map<String, dynamic> _employmentData = {
    'employmentStatus': '',
    'companyName': '',
    'jobTitle': '',
    'industry': '',
    'workExperience': 0,
    'annualIncome': 50000.0,
  };

  Map<String, dynamic> _verificationData = {
    'verificationMethod': '',
    'capturedImage': null,
  };

  final List<String> _formSteps = [
    'Personal\nInfo',
    'Employment\nDetails',
    'Identity\nVerification',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double get _formProgress {
    int completedSections = 0;

    // Check personal information completion
    if (_isPersonalSectionComplete()) completedSections++;

    // Check employment details completion
    if (_isEmploymentSectionComplete()) completedSections++;

    // Check verification completion
    if (_isVerificationSectionComplete()) completedSections++;

    return completedSections / 3.0;
  }

  int get _currentStep {
    if (!_isPersonalSectionComplete()) return 0;
    if (!_isEmploymentSectionComplete()) return 1;
    if (!_isVerificationSectionComplete()) return 2;
    return 3;
  }

  bool _isPersonalSectionComplete() {
    return _personalData['fullName']?.isNotEmpty == true &&
        _personalData['firstName']?.isNotEmpty == true &&
        _personalData['lastName']?.isNotEmpty == true &&
        _personalData['email']?.isNotEmpty == true &&
        _personalData['phone']?.isNotEmpty == true &&
        _personalData['dateOfBirth']?.isNotEmpty == true &&
        _personalData['ssn']?.isNotEmpty == true &&
        _personalData['address']?.isNotEmpty == true &&
        _personalData['city']?.isNotEmpty == true &&
        _personalData['state']?.isNotEmpty == true &&
        _personalData['zipCode']?.isNotEmpty == true;
  }

  bool _isEmploymentSectionComplete() {
    return _employmentData['employmentStatus']?.isNotEmpty == true &&
        _employmentData['companyName']?.isNotEmpty == true &&
        _employmentData['jobTitle']?.isNotEmpty == true &&
        _employmentData['industry']?.isNotEmpty == true &&
        (_employmentData['workExperience'] ?? 0) > 0;
  }

  bool _isVerificationSectionComplete() {
    return _verificationData['verificationMethod']?.isNotEmpty == true &&
        _verificationData['capturedImage'] != null;
  }

  bool get _canSubmitApplication {
    return _isPersonalSectionComplete() &&
        _isEmploymentSectionComplete() &&
        _isVerificationSectionComplete();
  }

  double get _estimatedCreditLimit {
    double income = (_employmentData['annualIncome'] ?? 50000.0).toDouble();
    double baseLimit = income * 0.05; // 5% of annual income

    // Adjust based on employment status
    String employmentStatus = _employmentData['employmentStatus'] ?? '';
    switch (employmentStatus) {
      case 'Full-time Employee':
        baseLimit *= 1.2;
        break;
      case 'Part-time Employee':
        baseLimit *= 0.8;
        break;
      case 'Self-employed':
        baseLimit *= 0.9;
        break;
      case 'Freelancer':
        baseLimit *= 0.7;
        break;
      default:
        baseLimit *= 0.5;
    }

    // Cap at $2,500
    return baseLimit > 2500 ? 2500 : baseLimit;
  }

  void _onPersonalFieldChanged(String field, String value) {
    setState(() {
      _personalData[field] = value;
    });
  }

  void _onEmploymentFieldChanged(String field, dynamic value) {
    setState(() {
      _employmentData[field] = value;
    });
  }

  void _onVerificationFieldChanged(String field, dynamic value) {
    setState(() {
      _verificationData[field] = value;
    });
  }

  void _saveProgress() {
    HapticFeedback.lightImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            CustomIconWidget(
              iconName: 'check_circle',
              color: AppTheme.successGreen,
              size: 20,
            ),
            SizedBox(width: 2.w),
            Text('Progress saved successfully!'),
          ],
        ),
        backgroundColor: AppTheme.surfaceDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _submitApplication() async {
    if (!_canSubmitApplication) return;

    setState(() {
      _isSubmitting = true;
    });

    HapticFeedback.mediumImpact();

    // Simulate processing time
    await Future.delayed(Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });

      // Navigate to instant credit decision
      Navigator.pushNamed(context, '/instant-credit-decision');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        title: Text('Credit Application'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => _buildHelpDialog(),
              );
            },
            icon: CustomIconWidget(
              iconName: 'help_outline',
              color: AppTheme.textPrimary,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: EdgeInsets.all(4.w),
            child: FormProgressIndicator(
              progress: _formProgress,
              steps: _formSteps,
              currentStep: _currentStep,
            ),
          ),

          // Form content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  PersonalInformationSection(
                    personalData: _personalData,
                    onFieldChanged: _onPersonalFieldChanged,
                  ),

                  EmploymentDetailsSection(
                    employmentData: _employmentData,
                    onFieldChanged: _onEmploymentFieldChanged,
                    creditLimit: _estimatedCreditLimit,
                  ),

                  IdentityVerificationSection(
                    verificationData: _verificationData,
                    onFieldChanged: _onVerificationFieldChanged,
                  ),

                  SizedBox(height: 10.h), // Space for bottom buttons
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom action buttons
      bottomNavigationBar: FormActionButtons(
        onSaveProgress: _saveProgress,
        onSubmitApplication: _submitApplication,
        isSubmitting: _isSubmitting,
        canSubmit: _canSubmitApplication,
      ),
    );
  }

  Widget _buildHelpDialog() {
    return AlertDialog(
      backgroundColor: AppTheme.dialogDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          CustomIconWidget(
            iconName: 'help',
            color: AppTheme.primaryGold,
            size: 24,
          ),
          SizedBox(width: 2.w),
          Text(
            'Application Help',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHelpItem(
            'Personal Information',
            'Pre-filled from your Chronos profile. Update any incorrect details.',
          ),
          SizedBox(height: 2.h),
          _buildHelpItem(
            'Employment Details',
            'Your income affects your credit limit. Higher income = higher limit (up to \$2,500).',
          ),
          SizedBox(height: 2.h),
          _buildHelpItem(
            'Identity Verification',
            'Choose face scan for quick verification or ID card scan for traditional method.',
          ),
          SizedBox(height: 2.h),
          _buildHelpItem(
            'Security',
            'All data is encrypted and stored securely. We never share your information.',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Got it'),
        ),
      ],
    );
  }

  Widget _buildHelpItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            color: AppTheme.primaryGold,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          description,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
