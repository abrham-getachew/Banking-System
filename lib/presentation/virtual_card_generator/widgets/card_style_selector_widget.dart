import 'package:flutter/material.dart';

class CardStyleSelectorWidget extends StatelessWidget {
  final String selectedStyle;
  final Function(String) onStyleSelected;

  const CardStyleSelectorWidget({
    Key? key,
    required this.selectedStyle,
    required this.onStyleSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Style',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStyleOption(
                context,
                'Classic',
                'Clean minimal design',
                Icons.credit_card,
                selectedStyle == 'Classic',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStyleOption(
                context,
                'Premium',
                'Gradient effects',
                Icons.auto_awesome,
                selectedStyle == 'Premium',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStyleOption(
                context,
                'Elite',
                'Metallic finish',
                Icons.diamond,
                selectedStyle == 'Elite',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStyleOption(
    BuildContext context,
    String style,
    String description,
    IconData icon,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () => onStyleSelected(style),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF9e814e).withAlpha(26)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF9e814e)
                : Colors.grey.withAlpha(77),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF9e814e).withAlpha(51),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF9e814e)
                    : Colors.grey.withAlpha(51),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[600],
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              style,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? const Color(0xFF9e814e) : null,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
