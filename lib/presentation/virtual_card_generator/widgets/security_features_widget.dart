import 'package:flutter/material.dart';

class SecurityFeaturesWidget extends StatefulWidget {
  const SecurityFeaturesWidget({Key? key}) : super(key: key);

  @override
  State<SecurityFeaturesWidget> createState() => _SecurityFeaturesWidgetState();
}

class _SecurityFeaturesWidgetState extends State<SecurityFeaturesWidget> {
  bool _isDynamicCVVEnabled = true;
  bool _isContactlessEnabled = true;
  bool _isCardFrozen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Security Features',
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
          ),
          child: Column(
            children: [
              _buildSecurityOption(
                context,
                'Dynamic CVV Rotation',
                'CVV changes every transaction',
                Icons.refresh,
                _isDynamicCVVEnabled,
                (value) => setState(() => _isDynamicCVVEnabled = value),
                true,
              ),
              const Divider(height: 24),
              _buildSecurityOption(
                context,
                'Contactless Payment',
                'Tap to pay capability',
                Icons.contactless,
                _isContactlessEnabled,
                (value) => setState(() => _isContactlessEnabled = value),
                false,
              ),
              const Divider(height: 24),
              _buildSecurityOption(
                context,
                'Instant Freeze/Unfreeze',
                'Control card usage instantly',
                _isCardFrozen ? Icons.lock : Icons.lock_open,
                _isCardFrozen,
                (value) => setState(() => _isCardFrozen = value),
                false,
                isToggleCard: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityOption(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    bool isEnabled,
    Function(bool) onChanged,
    bool isPremiumFeature, {
    bool isToggleCard = false,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isEnabled
                ? const Color(0xFF9e814e).withAlpha(26)
                : Colors.grey.withAlpha(26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isEnabled ? const Color(0xFF9e814e) : Colors.grey[600],
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (isPremiumFeature) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9e814e),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'PRO',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
        Switch(
          value: isEnabled,
          onChanged: onChanged,
          activeColor:
              isToggleCard && isEnabled ? Colors.red : const Color(0xFF9e814e),
        ),
      ],
    );
  }
}
