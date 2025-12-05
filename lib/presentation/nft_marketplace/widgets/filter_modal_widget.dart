import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterModalWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterModalWidget({
    Key? key,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  State<FilterModalWidget> createState() => _FilterModalWidgetState();
}

class _FilterModalWidgetState extends State<FilterModalWidget> {
  RangeValues _priceRange = const RangeValues(0, 100);
  String _selectedRarity = 'All';
  String _selectedSaleStatus = 'All';
  String _selectedBlockchain = 'Ethereum';
  List<String> _selectedTraits = [];

  final List<String> _rarityOptions = [
    'All',
    'Common',
    'Rare',
    'Epic',
    'Legendary'
  ];
  final List<String> _saleStatusOptions = [
    'All',
    'Buy Now',
    'On Auction',
    'New'
  ];
  final List<String> _blockchainOptions = [
    'Ethereum',
    'Polygon',
    'Solana',
    'Binance Smart Chain'
  ];
  final List<String> _traitOptions = [
    'Blue Background',
    'Laser Eyes',
    'Gold Chain',
    'Purple Waves',
    'Sound Bars',
    'Neon Glow'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceModal,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.borderGray,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Container(
            padding: EdgeInsets.all(4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: AppTheme.darkTheme.textTheme.titleLarge,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: _resetFilters,
                      child: Text(
                        'Reset',
                        style:
                            AppTheme.darkTheme.textTheme.labelLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: CustomIconWidget(
                        iconName: 'close',
                        color: AppTheme.textSecondary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(color: AppTheme.borderGray, height: 1),

          // Filter Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Range
                  _buildFilterSection(
                    title: 'Price Range (ETH)',
                    child: Column(
                      children: [
                        RangeSlider(
                          values: _priceRange,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          labels: RangeLabels(
                            _priceRange.start.toStringAsFixed(1),
                            _priceRange.end.toStringAsFixed(1),
                          ),
                          onChanged: (values) {
                            setState(() {
                              _priceRange = values;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_priceRange.start.toStringAsFixed(1)} ETH',
                              style: AppTheme.darkTheme.textTheme.bodySmall,
                            ),
                            Text(
                              '${_priceRange.end.toStringAsFixed(1)} ETH',
                              style: AppTheme.darkTheme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Rarity
                  _buildFilterSection(
                    title: 'Rarity',
                    child: Wrap(
                      spacing: 2.w,
                      runSpacing: 1.h,
                      children: _rarityOptions.map((rarity) {
                        final isSelected = _selectedRarity == rarity;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedRarity = rarity;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.accentGold
                                  : AppTheme.secondaryDark,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.accentGold
                                    : AppTheme.borderGray,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              rarity,
                              style: AppTheme.darkTheme.textTheme.labelMedium
                                  ?.copyWith(
                                color: isSelected
                                    ? AppTheme.primaryDark
                                    : AppTheme.textPrimary,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Sale Status
                  _buildFilterSection(
                    title: 'Sale Status',
                    child: Column(
                      children: _saleStatusOptions.map((status) {
                        final isSelected = _selectedSaleStatus == status;
                        return RadioListTile<String>(
                          value: status,
                          groupValue: _selectedSaleStatus,
                          onChanged: (value) {
                            setState(() {
                              _selectedSaleStatus = value!;
                            });
                          },
                          title: Text(
                            status,
                            style: AppTheme.darkTheme.textTheme.bodyMedium,
                          ),
                          activeColor: AppTheme.accentGold,
                          contentPadding: EdgeInsets.zero,
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Blockchain
                  _buildFilterSection(
                    title: 'Blockchain',
                    child: DropdownButtonFormField<String>(
                      value: _selectedBlockchain,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppTheme.secondaryDark,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.5.h),
                      ),
                      dropdownColor: AppTheme.secondaryDark,
                      style: AppTheme.darkTheme.textTheme.bodyMedium,
                      items: _blockchainOptions.map((blockchain) {
                        return DropdownMenuItem(
                          value: blockchain,
                          child: Text(blockchain),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBlockchain = value!;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Traits
                  _buildFilterSection(
                    title: 'Traits',
                    child: Wrap(
                      spacing: 2.w,
                      runSpacing: 1.h,
                      children: _traitOptions.map((trait) {
                        final isSelected = _selectedTraits.contains(trait);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedTraits.remove(trait);
                              } else {
                                _selectedTraits.add(trait);
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.accentGold.withValues(alpha: 0.2)
                                  : AppTheme.secondaryDark,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.accentGold
                                    : AppTheme.borderGray,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isSelected)
                                  CustomIconWidget(
                                    iconName: 'check',
                                    color: AppTheme.accentGold,
                                    size: 14,
                                  ),
                                if (isSelected) SizedBox(width: 1.w),
                                Text(
                                  trait,
                                  style: AppTheme
                                      .darkTheme.textTheme.labelMedium
                                      ?.copyWith(
                                    color: isSelected
                                        ? AppTheme.accentGold
                                        : AppTheme.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),

          // Apply Button
          Container(
            padding: EdgeInsets.all(4.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                child: Text('Apply Filters'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.darkTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 2.h),
        child,
      ],
    );
  }

  void _resetFilters() {
    setState(() {
      _priceRange = const RangeValues(0, 100);
      _selectedRarity = 'All';
      _selectedSaleStatus = 'All';
      _selectedBlockchain = 'Ethereum';
      _selectedTraits.clear();
    });
  }

  void _applyFilters() {
    final filters = {
      'priceRange': _priceRange,
      'rarity': _selectedRarity,
      'saleStatus': _selectedSaleStatus,
      'blockchain': _selectedBlockchain,
      'traits': _selectedTraits,
    };

    widget.onApplyFilters(filters);
  }
}
