import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardDetailsWidget extends StatelessWidget {
  final String cardNumber;
  final String expirationDate;
  final String cvv;

  const CardDetailsWidget({
    Key? key,
    required this.cardNumber,
    required this.expirationDate,
    required this.cvv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Details',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF9e814e).withAlpha(51),
            ),
          ),
          child: Column(
            children: [
              _buildDetailRow(
                context,
                'Card Number',
                cardNumber,
                Icons.credit_card,
                true,
              ),
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailRow(
                      context,
                      'Expires',
                      expirationDate,
                      Icons.calendar_today,
                      false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDetailRow(
                      context,
                      'CVV',
                      cvv,
                      Icons.security,
                      true,
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

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    bool canCopy,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: const Color(0xFF9e814e),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: label == 'Card Number' ? 1.2 : 0,
                    ),
              ),
            ),
            if (canCopy) ...[
              const SizedBox(width: 8),
              InkWell(
                onTap: () => _copyToClipboard(context, value, label),
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.copy,
                    size: 16,
                    color: Color(0xFF9e814e),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  void _copyToClipboard(BuildContext context, String value, String label) {
    Clipboard.setData(ClipboardData(text: value.replaceAll(' ', '')));
    HapticFeedback.lightImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        backgroundColor: const Color(0xFF9e814e),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
