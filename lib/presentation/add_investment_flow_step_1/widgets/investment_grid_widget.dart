import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import './investment_type_card.dart';

class InvestmentGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> investmentTypes;
  final String? selectedType;
  final Function(String) onTypeSelected;

  const InvestmentGridWidget({
    super.key,
    required this.investmentTypes,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 2.w,
              mainAxisSpacing: 2.h,
            ),
            itemCount: investmentTypes.length,
            itemBuilder: (context, index) {
              final investment = investmentTypes[index];
              final isSelected = selectedType == investment['type'];

              return InvestmentTypeCard(
                title: investment['title'] as String,
                description: investment['description'] as String,
                iconName: investment['icon'] as String,
                riskLevel: investment['riskLevel'] as String,
                isSelected: isSelected,
                onTap: () => onTypeSelected(investment['type'] as String),
              );
            },
          ),
        ),
      ),
    );
  }
}
