import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MarketsTabWidget extends StatefulWidget {
  final List<Map<String, dynamic>> cryptoData;
  final Function(String) onCoinTap;

  const MarketsTabWidget({
    Key? key,
    required this.cryptoData,
    required this.onCoinTap,
  }) : super(key: key);

  @override
  State<MarketsTabWidget> createState() => _MarketsTabWidgetState();
}

class _MarketsTabWidgetState extends State<MarketsTabWidget> {
  String _searchQuery = '';
  String _sortBy = 'market_cap'; // market_cap, price, volume, change
  bool _sortAscending = false;
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> get _filteredAndSortedData {
    var filtered = widget.cryptoData.where((crypto) {
      final name = (crypto["name"] as String).toLowerCase();
      final symbol = (crypto["symbol"] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || symbol.contains(query);
    }).toList();

    filtered.sort((a, b) {
      dynamic aValue, bValue;
      switch (_sortBy) {
        case 'price':
          aValue = a["currentPrice"];
          bValue = b["currentPrice"];
          break;
        case 'volume':
          aValue = a["volume24h"];
          bValue = b["volume24h"];
          break;
        case 'change':
          aValue = a["priceChangePercent24h"];
          bValue = b["priceChangePercent24h"];
          break;
        default:
          aValue = a["marketCap"];
          bValue = b["marketCap"];
      }

      final comparison =
          _sortAscending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      return comparison;
    });

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchAndSort(),
        _buildMarketHeader(),
        Expanded(
          child: _buildMarketList(),
        ),
      ],
    );
  }

  Widget _buildSearchAndSort() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search cryptocurrencies...',
              prefixIcon: CustomIconWidget(
                iconName: 'search',
                color: AppTheme.textSecondary,
                size: 20,
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                      icon: CustomIconWidget(
                        iconName: 'clear',
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                    )
                  : null,
            ),
          ),
          SizedBox(height: 2.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSortChip('Market Cap', 'market_cap'),
                SizedBox(width: 2.w),
                _buildSortChip('Price', 'price'),
                SizedBox(width: 2.w),
                _buildSortChip('Volume', 'volume'),
                SizedBox(width: 2.w),
                _buildSortChip('24h Change', 'change'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label, String sortKey) {
    final isSelected = _sortBy == sortKey;

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (isSelected) ...[
            SizedBox(width: 1.w),
            CustomIconWidget(
              iconName:
                  _sortAscending ? 'keyboard_arrow_up' : 'keyboard_arrow_down',
              color: AppTheme.accentGold,
              size: 16,
            ),
          ],
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (_sortBy == sortKey) {
            _sortAscending = !_sortAscending;
          } else {
            _sortBy = sortKey;
            _sortAscending = false;
          }
        });
      },
      selectedColor: AppTheme.accentGold.withValues(alpha: 0.2),
      checkmarkColor: AppTheme.accentGold,
    );
  }

  Widget _buildMarketHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark.withValues(alpha: 0.5),
        border: Border(
          bottom: BorderSide(color: AppTheme.borderGray.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Name',
              style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Price',
              textAlign: TextAlign.right,
              style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '24h Change',
              textAlign: TextAlign.right,
              style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 15.w), // Space for chart
        ],
      ),
    );
  }

  Widget _buildMarketList() {
    final data = _filteredAndSortedData;

    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'search_off',
              color: AppTheme.textSecondary,
              size: 48,
            ),
            SizedBox(height: 2.h),
            Text(
              'No cryptocurrencies found',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      itemCount: data.length,
      separatorBuilder: (context, index) => Divider(
        color: AppTheme.borderGray.withValues(alpha: 0.3),
        height: 1,
      ),
      itemBuilder: (context, index) {
        final crypto = data[index];
        return _buildMarketItem(crypto);
      },
    );
  }

  Widget _buildMarketItem(Map<String, dynamic> crypto) {
    final isPositive = (crypto["priceChangePercent24h"] as double) >= 0;
    final changeColor = isPositive ? AppTheme.successGreen : AppTheme.errorRed;
    final sparklineData = (crypto["sparklineData"] as List).cast<double>();

    return InkWell(
      onTap: () => widget.onCoinTap(crypto["id"] as String),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  CustomImageWidget(
                    imageUrl: crypto["logo"] as String,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          crypto["name"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          crypto["symbol"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${(crypto["currentPrice"] as double).toStringAsFixed(2)}',
                    style: AppTheme.getMonospaceStyle(
                      isLight: false,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '\$${_formatLargeNumber(crypto["marketCap"] as double)}',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: isPositive ? 'trending_up' : 'trending_down',
                        color: changeColor,
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${isPositive ? '+' : ''}${(crypto["priceChangePercent24h"] as double).toStringAsFixed(2)}%',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: changeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '\$${(crypto["priceChange24h"] as double).toStringAsFixed(2)}',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: changeColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 2.w),
            Container(
              width: 12.w,
              height: 6.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: sparklineData
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value))
                          .toList(),
                      isCurved: true,
                      color: changeColor,
                      barWidth: 1.5,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                  minY: sparklineData.reduce((a, b) => a < b ? a : b) * 0.999,
                  maxY: sparklineData.reduce((a, b) => a > b ? a : b) * 1.001,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatLargeNumber(double number) {
    if (number >= 1e12) {
      return '${(number / 1e12).toStringAsFixed(1)}T';
    } else if (number >= 1e9) {
      return '${(number / 1e9).toStringAsFixed(1)}B';
    } else if (number >= 1e6) {
      return '${(number / 1e6).toStringAsFixed(1)}M';
    } else if (number >= 1e3) {
      return '${(number / 1e3).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
}
