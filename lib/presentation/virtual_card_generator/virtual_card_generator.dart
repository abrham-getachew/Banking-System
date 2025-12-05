import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/card_details_widget.dart';
import './widgets/card_preview_widget.dart';
import './widgets/card_style_selector_widget.dart';
import './widgets/color_palette_widget.dart';
import './widgets/generation_buttons_widget.dart';
import './widgets/personalization_widget.dart';
import './widgets/security_features_widget.dart';

class VirtualCardGenerator extends StatefulWidget {
  const VirtualCardGenerator({Key? key}) : super(key: key);

  @override
  State<VirtualCardGenerator> createState() => _VirtualCardGeneratorState();
}

class _VirtualCardGeneratorState extends State<VirtualCardGenerator>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _generationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  String _selectedCardStyle = 'Classic';
  Color _selectedColor = const Color(0xFF9e814e); // TickPay gold
  String _cardholderName = '';
  String _cardNumber = '**** **** **** ****';
  String _expirationDate = '**/**';
  String _cvv = '***';
  bool _isCardGenerated = false;
  bool _isGenerating = false;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _generationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _generationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _generationController.dispose();
    super.dispose();
  }

  void _onStyleSelected(String style) {
    setState(() {
      _selectedCardStyle = style;
    });
    _rotationController.forward().then((_) {
      _rotationController.reset();
    });
  }

  void _onColorSelected(Color color) {
    setState(() {
      _selectedColor = color;
    });
    HapticFeedback.lightImpact();
  }

  void _onNameChanged(String name) {
    setState(() {
      _cardholderName = name;
    });
  }

  Future<void> _generateCard() async {
    setState(() {
      _isGenerating = true;
      _progressValue = 0.0;
    });

    HapticFeedback.mediumImpact();

    // Simulate card generation process
    for (int i = 0; i <= 100; i += 2) {
      await Future.delayed(const Duration(milliseconds: 30));
      setState(() {
        _progressValue = i / 100;
      });
    }

    // Generate card details
    setState(() {
      _cardNumber = '4532 1234 5678 9012';
      _expirationDate = '12/28';
      _cvv = '123';
      _isCardGenerated = true;
      _isGenerating = false;
    });

    _generationController.forward().then((_) {
      _generationController.reset();
    });

    HapticFeedback.heavyImpact();

    // Show success animation
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF9e814e),
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9e814e),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Card Generated Successfully!',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Your virtual card is ready to use',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 48),
                  ),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _orderPhysicalCard() async {
    HapticFeedback.lightImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
            'Physical card ordered! Expected delivery: 5-7 business days'),
        backgroundColor: const Color(0xFF9e814e),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Virtual Card Generator',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF9e814e).withAlpha(26),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9e814e),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _isCardGenerated ? 'Complete' : 'In Progress',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xFF9e814e),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Preview
            AnimatedBuilder(
              animation: _rotationAnimation,
              child: CardPreviewWidget(
                cardStyle: _selectedCardStyle,
                cardColor: _selectedColor,
                cardholderName: _cardholderName.isEmpty
                    ? 'Your Name'
                    : _cardholderName.toUpperCase(),
                cardNumber: _cardNumber,
                expirationDate: _expirationDate,
              ),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(_rotationAnimation.value * 3.14159),
                  child: child,
                );
              },
            ),

            const SizedBox(height: 24),

            // Card Style Selector
            CardStyleSelectorWidget(
              selectedStyle: _selectedCardStyle,
              onStyleSelected: _onStyleSelected,
            ),

            const SizedBox(height: 24),

            // Color Palette
            ColorPaletteWidget(
              selectedColor: _selectedColor,
              onColorSelected: _onColorSelected,
            ),

            const SizedBox(height: 24),

            // Personalization
            PersonalizationWidget(
              cardholderName: _cardholderName,
              onNameChanged: _onNameChanged,
            ),

            const SizedBox(height: 24),

            // Security Features
            const SecurityFeaturesWidget(),

            const SizedBox(height: 24),

            // Card Details (if generated)
            if (_isCardGenerated) ...[
              CardDetailsWidget(
                cardNumber: _cardNumber,
                expirationDate: _expirationDate,
                cvv: _cvv,
              ),
              const SizedBox(height: 24),
            ],

            // Generation Progress (if generating)
            if (_isGenerating) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Generating Your Card...',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: _progressValue,
                      backgroundColor: const Color(0xFF9e814e).withAlpha(51),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF9e814e),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(_progressValue * 100).toInt()}%',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Action Buttons
            GenerationButtonsWidget(
              isCardGenerated: _isCardGenerated,
              isGenerating: _isGenerating,
              canGenerate: _cardholderName.isNotEmpty,
              onGenerateCard: _generateCard,
              onOrderPhysicalCard: _orderPhysicalCard,
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
