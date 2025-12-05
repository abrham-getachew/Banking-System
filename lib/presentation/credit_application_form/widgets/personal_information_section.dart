import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PersonalInformationSection extends StatelessWidget {
  final Map<String, dynamic> personalData;
  final Function(String, String) onFieldChanged;

  const PersonalInformationSection({
    super.key,
    required this.personalData,
    required this.onFieldChanged,
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
                  iconName: 'person',
                  color: AppTheme.primaryGold,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Personal Information',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryGold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            _buildTextField(
              label: 'Full Name *',
              value: personalData['fullName'] ?? '',
              keyboardType: TextInputType.name,
              onChanged: (value) => onFieldChanged('fullName', value),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'First Name *',
                    value: personalData['firstName'] ?? '',
                    keyboardType: TextInputType.name,
                    onChanged: (value) => onFieldChanged('firstName', value),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildTextField(
                    label: 'Last Name *',
                    value: personalData['lastName'] ?? '',
                    keyboardType: TextInputType.name,
                    onChanged: (value) => onFieldChanged('lastName', value),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            _buildTextField(
              label: 'Email Address *',
              value: personalData['email'] ?? '',
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => onFieldChanged('email', value),
            ),
            SizedBox(height: 2.h),
            _buildTextField(
              label: 'Phone Number *',
              value: personalData['phone'] ?? '',
              keyboardType: TextInputType.phone,
              onChanged: (value) => onFieldChanged('phone', value),
            ),
            SizedBox(height: 2.h),
            _buildTextField(
              label: 'Date of Birth *',
              value: personalData['dateOfBirth'] ?? '',
              keyboardType: TextInputType.datetime,
              onChanged: (value) => onFieldChanged('dateOfBirth', value),
              suffixIcon: CustomIconWidget(
                iconName: 'calendar_today',
                color: AppTheme.textSecondary,
                size: 20,
              ),
            ),
            SizedBox(height: 2.h),
            _buildTextField(
              label: 'Social Security Number *',
              value: personalData['ssn'] ?? '',
              keyboardType: TextInputType.number,
              onChanged: (value) => onFieldChanged('ssn', value),
              obscureText: true,
            ),
            SizedBox(height: 2.h),
            _buildTextField(
              label: 'Address *',
              value: personalData['address'] ?? '',
              keyboardType: TextInputType.streetAddress,
              onChanged: (value) => onFieldChanged('address', value),
              maxLines: 2,
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildTextField(
                    label: 'City *',
                    value: personalData['city'] ?? '',
                    keyboardType: TextInputType.text,
                    onChanged: (value) => onFieldChanged('city', value),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildTextField(
                    label: 'State *',
                    value: personalData['state'] ?? '',
                    keyboardType: TextInputType.text,
                    onChanged: (value) => onFieldChanged('state', value),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildTextField(
                    label: 'ZIP Code *',
                    value: personalData['zipCode'] ?? '',
                    keyboardType: TextInputType.number,
                    onChanged: (value) => onFieldChanged('zipCode', value),
                  ),
                ),
              ],
            ),
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
    Widget? suffixIcon,
    bool obscureText = false,
    int maxLines = 1,
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
          obscureText: obscureText,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Enter ${label.replaceAll(' *', '')}',
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.all(3.w),
                    child: suffixIcon,
                  )
                : (value.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: 'check_circle',
                          color: AppTheme.successGreen,
                          size: 20,
                        ),
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}
