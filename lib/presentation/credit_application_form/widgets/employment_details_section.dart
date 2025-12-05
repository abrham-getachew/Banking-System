import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmploymentDetailsSection extends StatelessWidget {
  final Map<String, dynamic> employmentData;
  final Function(String, dynamic) onFieldChanged;
  final double creditLimit;

  const EmploymentDetailsSection({
    super.key,
    required this.employmentData,
    required this.onFieldChanged,
    required this.creditLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'work',
                  color: AppTheme.primaryGold,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Employment Details',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryGold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            _buildDropdownField(
              label: 'Employment Status *',
              value: employmentData['employmentStatus'] ?? '',
              items: [
                'Full-time Employee',
                'Part-time Employee',
                'Self-employed',
                'Freelancer',
                'Student',
                'Unemployed',
                'Retired',
              ],
              onChanged: (value) => onFieldChanged('employmentStatus', value),
            ),
            SizedBox(height: 2.h),
            _buildTextField(
              label: 'Company Name *',
              value: employmentData['companyName'] ?? '',
              keyboardType: TextInputType.text,
              onChanged: (value) => onFieldChanged('companyName', value),
            ),
            SizedBox(height: 2.h),
            _buildTextField(
              label: 'Job Title *',
              value: employmentData['jobTitle'] ?? '',
              keyboardType: TextInputType.text,
              onChanged: (value) => onFieldChanged('jobTitle', value),
            ),
            SizedBox(height: 2.h),
            _buildDropdownField(
              label: 'Industry *',
              value: employmentData['industry'] ?? '',
              items: [
                'Technology',
                'Healthcare',
                'Finance',
                'Education',
                'Retail',
                'Manufacturing',
                'Construction',
                'Transportation',
                'Hospitality',
                'Government',
                'Other',
              ],
              onChanged: (value) => onFieldChanged('industry', value),
            ),
            SizedBox(height: 2.h),
            _buildTextField(
              label: 'Work Experience (Years) *',
              value: employmentData['workExperience']?.toString() ?? '',
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  onFieldChanged('workExperience', int.tryParse(value) ?? 0),
            ),
            SizedBox(height: 2.h),
            _buildIncomeSlider(),
            SizedBox(height: 2.h),
            _buildCreditLimitDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required TextInputType keyboardType,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        SizedBox(height: 0.5.h),
        TextFormField(
          initialValue: value,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Enter ${label.replaceAll(' *', '')}',
            suffixIcon: value.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'check_circle',
                      color: AppTheme.successGreen,
                      size: 20,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        SizedBox(height: 0.5.h),
        DropdownButtonFormField<String>(
          value: value.isEmpty ? null : value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Select ${label.replaceAll(' *', '')}',
            suffixIcon: value.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'check_circle',
                      color: AppTheme.successGreen,
                      size: 20,
                    ),
                  )
                : null,
          ),
          dropdownColor: AppTheme.surfaceDark,
        ),
      ],
    );
  }

  Widget _buildIncomeSlider() {
    double income = (employmentData['annualIncome'] ?? 30000.0).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Annual Income *',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.primaryGold.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 1.h),
              Builder(
                builder: (context) => SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppTheme.primaryGold,
                    thumbColor: AppTheme.primaryGold,
                    overlayColor: AppTheme.primaryGold.withValues(alpha: 0.2),
                    inactiveTrackColor:
                        AppTheme.neutralGray.withValues(alpha: 0.3),
                  ),
                  child: Slider(
                    value: income,
                    min: 20000,
                    max: 200000,
                    divisions: 36,
                    onChanged: (value) {
                      onFieldChanged('annualIncome', value);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$20K',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  Text(
                    '\$200K+',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCreditLimitDisplay() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryGold.withValues(alpha: 0.1),
            AppTheme.primaryGold.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'account_balance_wallet',
            color: AppTheme.primaryGold,
            size: 24,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estimated Credit Limit',
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '\$${creditLimit.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                    color: AppTheme.primaryGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          CustomIconWidget(
            iconName: 'trending_up',
            color: AppTheme.successGreen,
            size: 20,
          ),
        ],
      ),
    );
  }
}
