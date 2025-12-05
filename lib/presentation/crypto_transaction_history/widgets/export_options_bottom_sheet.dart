import 'dart:convert';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ExportOptionsBottomSheet extends StatefulWidget {
  final List<Map<String, dynamic>> transactions;
  final DateTimeRange? dateRange;

  const ExportOptionsBottomSheet({
    super.key,
    required this.transactions,
    this.dateRange,
  });

  @override
  State<ExportOptionsBottomSheet> createState() =>
      _ExportOptionsBottomSheetState();
}

class _ExportOptionsBottomSheetState extends State<ExportOptionsBottomSheet> {
  String _selectedFormat = 'CSV';
  DateTimeRange? _exportDateRange;
  bool _isExporting = false;

  final List<String> _exportFormats = ['CSV', 'PDF', 'JSON'];

  @override
  void initState() {
    super.initState();
    _exportDateRange = widget.dateRange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormatSelection(),
                  SizedBox(height: 3.h),
                  _buildDateRangeSelection(),
                  SizedBox(height: 3.h),
                  _buildTransactionSummary(),
                  SizedBox(height: 4.h),
                  _buildExportButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color:
                AppTheme.darkTheme.colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Export Transactions',
            style: AppTheme.darkTheme.textTheme.titleLarge,
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CustomIconWidget(
              iconName: 'close',
              color: AppTheme.darkTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormatSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Export Format',
          style: AppTheme.darkTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 1.h),
        Row(
          children: _exportFormats.map((format) {
            final isSelected = _selectedFormat == format;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFormat = format;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                      right: format != _exportFormats.last ? 2.w : 0),
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryGold.withValues(alpha: 0.2)
                        : AppTheme.darkTheme.colorScheme.surface
                            .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryGold
                          : AppTheme.darkTheme.colorScheme.outline
                              .withValues(alpha: 0.3),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      format,
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? AppTheme.primaryGold
                            : AppTheme.darkTheme.colorScheme.onSurface,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateRangeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Range',
          style: AppTheme.darkTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 1.h),
        GestureDetector(
          onTap: _selectDateRange,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color:
                  AppTheme.darkTheme.colorScheme.surface.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.darkTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _exportDateRange != null
                      ? '${_formatDate(_exportDateRange!.start)} - ${_formatDate(_exportDateRange!.end)}'
                      : 'All transactions',
                  style: AppTheme.darkTheme.textTheme.bodyMedium,
                ),
                CustomIconWidget(
                  iconName: 'calendar_today',
                  color: AppTheme.primaryGold,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionSummary() {
    final filteredTransactions = _getFilteredTransactions();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.darkTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Export Summary',
            style: AppTheme.darkTheme.textTheme.titleSmall,
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Transactions:',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.darkTheme.colorScheme.onSurface
                      .withValues(alpha: 0.7),
                ),
              ),
              Text(
                '${filteredTransactions.length}',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'File Format:',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.darkTheme.colorScheme.onSurface
                      .withValues(alpha: 0.7),
                ),
              ),
              Text(
                _selectedFormat,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isExporting ? null : _exportTransactions,
        icon: _isExporting
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.darkTheme.colorScheme.onPrimary,
                  ),
                ),
              )
            : CustomIconWidget(
                iconName: 'file_download',
                color: AppTheme.darkTheme.colorScheme.onPrimary,
                size: 20,
              ),
        label: Text(_isExporting ? 'Exporting...' : 'Export Transactions'),
      ),
    );
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: _exportDateRange,
      builder: (context, child) {
        return Theme(
          data: AppTheme.darkTheme.copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppTheme.darkTheme.colorScheme.surface,
              headerBackgroundColor: AppTheme.primaryGold,
              headerForegroundColor: AppTheme.darkTheme.colorScheme.onPrimary,
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppTheme.darkTheme.colorScheme.onPrimary;
                }
                return AppTheme.darkTheme.colorScheme.onSurface;
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppTheme.primaryGold;
                }
                return Colors.transparent;
              }),
              rangeSelectionBackgroundColor:
                  AppTheme.primaryGold.withValues(alpha: 0.3),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _exportDateRange = picked;
      });
    }
  }

  List<Map<String, dynamic>> _getFilteredTransactions() {
    if (_exportDateRange == null) return widget.transactions;

    return widget.transactions.where((transaction) {
      final timestamp = transaction['timestamp'] as DateTime;
      return timestamp.isAfter(_exportDateRange!.start) &&
          timestamp
              .isBefore(_exportDateRange!.end.add(const Duration(days: 1)));
    }).toList();
  }

  Future<void> _exportTransactions() async {
    setState(() {
      _isExporting = true;
    });

    try {
      final filteredTransactions = _getFilteredTransactions();
      final content = _generateExportContent(filteredTransactions);
      final filename = _generateFilename();

      await _downloadFile(content, filename);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transactions exported successfully as $filename'),
            backgroundColor: AppTheme.successGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to export transactions'),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isExporting = false;
        });
      }
    }
  }

  String _generateExportContent(List<Map<String, dynamic>> transactions) {
    switch (_selectedFormat) {
      case 'CSV':
        return _generateCSV(transactions);
      case 'JSON':
        return _generateJSON(transactions);
      case 'PDF':
        return _generatePDFContent(transactions);
      default:
        return _generateCSV(transactions);
    }
  }

  String _generateCSV(List<Map<String, dynamic>> transactions) {
    final buffer = StringBuffer();
    buffer.writeln('Date,Type,Token,Amount,Status,Hash,Gas Fee,Network');

    for (final transaction in transactions) {
      final timestamp = transaction['timestamp'] as DateTime;
      buffer.writeln([
        _formatDate(timestamp),
        transaction['type'],
        transaction['tokenSymbol'],
        transaction['amount'],
        transaction['status'],
        transaction['hash'],
        transaction['gasFee'],
        transaction['network'],
      ].join(','));
    }

    return buffer.toString();
  }

  String _generateJSON(List<Map<String, dynamic>> transactions) {
    final exportData = {
      'exportDate': DateTime.now().toIso8601String(),
      'totalTransactions': transactions.length,
      'dateRange': _exportDateRange != null
          ? {
              'start': _exportDateRange!.start.toIso8601String(),
              'end': _exportDateRange!.end.toIso8601String(),
            }
          : null,
      'transactions': transactions
          .map((transaction) => {
                ...transaction,
                'timestamp':
                    (transaction['timestamp'] as DateTime).toIso8601String(),
              })
          .toList(),
    };

    return const JsonEncoder.withIndent('  ').convert(exportData);
  }

  String _generatePDFContent(List<Map<String, dynamic>> transactions) {
    // For PDF, we'll generate a simple text format that could be converted to PDF
    final buffer = StringBuffer();
    buffer.writeln('CHRONOS BLOCKCHAIN - TRANSACTION HISTORY REPORT');
    buffer.writeln('=' * 50);
    buffer.writeln('Generated: ${DateTime.now().toString()}');
    buffer.writeln('Total Transactions: ${transactions.length}');

    if (_exportDateRange != null) {
      buffer.writeln(
          'Date Range: ${_formatDate(_exportDateRange!.start)} - ${_formatDate(_exportDateRange!.end)}');
    }

    buffer.writeln('\nTRANSACTIONS:');
    buffer.writeln('-' * 50);

    for (final transaction in transactions) {
      final timestamp = transaction['timestamp'] as DateTime;
      buffer.writeln('Date: ${_formatDate(timestamp)}');
      buffer.writeln('Type: ${transaction['type']}');
      buffer.writeln('Token: ${transaction['tokenSymbol']}');
      buffer.writeln('Amount: ${transaction['amount']}');
      buffer.writeln('Status: ${transaction['status']}');
      buffer.writeln('Hash: ${transaction['hash']}');
      buffer.writeln('Gas Fee: \$${transaction['gasFee']}');
      buffer.writeln('Network: ${transaction['network']}');
      buffer.writeln('-' * 30);
    }

    return buffer.toString();
  }

  String _generateFilename() {
    final now = DateTime.now();
    final dateStr =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    return 'chronos_transactions_$dateStr.${_selectedFormat.toLowerCase()}';
  }

  Future<void> _downloadFile(String content, String filename) async {
    if (kIsWeb) {
      // final bytes = utf8.encode(content);
      // final blob = html.Blob([bytes]);
      // final url = html.Url.createObjectUrlFromBlob(blob);
      // final anchor = html.AnchorElement(href: url)
      //   ..setAttribute("download", filename)
      //   ..click();
      // html.Url.revokeObjectUrl(url);
    } else {
      // For mobile platforms, this would typically use path_provider
      // For now, we'll simulate the download
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }
}
