import 'package:flutter/material.dart';

class GenerationButtonsWidget extends StatelessWidget {
  final bool isCardGenerated;
  final bool isGenerating;
  final bool canGenerate;
  final VoidCallback onGenerateCard;
  final VoidCallback onOrderPhysicalCard;

  const GenerationButtonsWidget({
    Key? key,
    required this.isCardGenerated,
    required this.isGenerating,
    required this.canGenerate,
    required this.onGenerateCard,
    required this.onOrderPhysicalCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Generate Card Button
        if (!isCardGenerated) ...[
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: canGenerate && !isGenerating ? onGenerateCard : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9e814e),
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey[300],
                elevation: canGenerate && !isGenerating ? 4 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isGenerating) ...[
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Generating...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ] else ...[
                    const Icon(
                      Icons.auto_awesome,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Generate Card',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (!canGenerate) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.orange[600],
                ),
                const SizedBox(width: 8),
                Text(
                  'Please enter cardholder name to continue',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.orange[600],
                      ),
                ),
              ],
            ),
          ],
        ],

        // Order Physical Card Button (appears after generation)
        if (isCardGenerated) ...[
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onOrderPhysicalCard,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9e814e),
                foregroundColor: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Order Physical Card',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(26),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.blue[700],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Physical card delivery: 5-7 business days • Free shipping',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blue[700],
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
