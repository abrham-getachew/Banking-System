import 'package:flutter/material.dart';

class ColorPaletteWidget extends StatelessWidget {
  final Color selectedColor;
  final Function(Color) onColorSelected;

  const ColorPaletteWidget({
    Key? key,
    required this.selectedColor,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      const Color(0xFF9e814e), // TickPay gold
      const Color(0xFF1a1a1a), // Midnight black
      const Color(0xFF2563eb), // Royal blue
      const Color(0xFF059669), // Emerald green
      const Color(0xFFdc2626), // Ruby red
      const Color(0xFF7c3aed), // Violet purple
      const Color(0xFFea580c), // Sunset orange
      const Color(0xFF0891b2), // Cyan blue
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Palette',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: colors.map((color) => _buildColorOption(color)).toList(),
        ),
      ],
    );
  }

  Widget _buildColorOption(Color color) {
    final bool isSelected = selectedColor == color;

    return GestureDetector(
      onTap: () => onColorSelected(color),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(102),
              blurRadius: isSelected ? 12 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isSelected
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 24,
              )
            : null,
      ),
    );
  }
}
