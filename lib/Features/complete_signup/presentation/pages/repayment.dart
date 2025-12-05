import 'package:chronos/Features/complete_signup/presentation/pages/page_7.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For haptic feedback


class RepaymentPage extends StatefulWidget {
  @override
  _RepaymentPageState createState() => _RepaymentPageState();
}

class _RepaymentPageState extends State<RepaymentPage> with TickerProviderStateMixin {
  late AnimationController _entryAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late AnimationController _staggerController;

  late AnimationController _continuousController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _shineAnimation;
  late Animation<double> _twinkleAnimation;
  late Animation<double> _pulseAnimation;

  late AnimationController _rippleController;
  late Animation<double> _rippleAnimation;

  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  bool _payButtonPressed = false;
  bool _historyPressed = false;
  bool _planPressed = false;

  @override
  void initState() {
    super.initState();

    _entryAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _staggerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryAnimationController, curve: Curves.easeInOutQuad),
    );
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _entryAnimationController, curve: Curves.easeOutBack),
    );
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _entryAnimationController, curve: Curves.easeInOutCubic),
    );

    _entryAnimationController.forward();
    _staggerController.forward();

    _continuousController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _continuousController, curve: Curves.easeInOutSine),
    );

    _shineAnimation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _continuousController, curve: Curves.linear),
    );

    _twinkleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _continuousController, curve: Curves.easeInOutQuad),
    );

    _pulseAnimation = Tween<double>(begin: 0.99, end: 1.01).animate(
      CurvedAnimation(parent: _continuousController, curve: Curves.easeInOut),
    );

    _rippleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.0, end: 0.3).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _entryAnimationController.dispose();
    _staggerController.dispose();
    _continuousController.dispose();
    _rippleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _animateButtonPress(VoidCallback setter, VoidCallback onComplete) {
    HapticFeedback.lightImpact();
    setter();
    setState(() {});
    _rippleController.reset();
    _rippleController.forward();
    Future.delayed(Duration(milliseconds: 250), () {
      setter();
      setState(() {});
      onComplete();
    });
  }

  void _handleButtonPress(String buttonType, VoidCallback navigation) {
    bool Function() getPressedGetter() {
      switch (buttonType) {
        case 'pay':
          return () => _payButtonPressed;
        case 'history':
          return () => _historyPressed;
        case 'plan':
          return () => _planPressed;
        default:
          return () => false;
      }
    }

    VoidCallback setter() {
      return () {
        bool isPressed = getPressedGetter()();
        switch (buttonType) {
          case 'pay':
            _payButtonPressed = !isPressed;
            break;
          case 'history':
            _historyPressed = !isPressed;
            break;
          case 'plan':
            _planPressed = !isPressed;
            break;
          default:
            throw Exception('Unknown button type: $buttonType');
        }
      };
    }

    _animateButtonPress(setter(), navigation);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = Colors.teal[800] ?? Colors.teal; // TickPay primary brand color
    final accentColor = Colors.green[900] ?? Colors.green; // Dark green for financial trust
    final backgroundColor = Colors.grey[50] ?? Colors.white;
    final textColor = Colors.grey[900];

    final double scaleFactor = size.width < 360 ? 0.85 : size.width > 600 ? 1.2 : 1.0;
    final double cardHeight = size.height * 0.22;
    final double buttonWidth = size.width > 600 ? size.width * 0.45 : size.width * 0.46;
    final double fontScale = scaleFactor;
    final double paddingScale = size.width < 360 ? 0.8 : 1.0;

    final cardGradient = LinearGradient(
      colors: [accentColor, Colors.green[600]!], // Dark green gradient
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: AnimatedScale(
            scale: 1.0,
            duration: Duration(milliseconds: 200),
            child: Icon(Icons.arrow_back, color: primaryColor, size: 24 * fontScale),
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        title: AnimatedBuilder(
          animation: _fadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Text(
                'Repayments',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20 * fontScale,
                  letterSpacing: 0.5,
                ),
              ),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: AnimatedRotation(
              turns: 0.0,
              duration: Duration(milliseconds: 300),
              child: Icon(Icons.settings_outlined, color: primaryColor, size: 24 * fontScale),
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TickPaySettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05 * paddingScale,
                vertical: 12 * paddingScale,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedBuilder(
                    animation: _entryAnimationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: Opacity(
                          opacity: _fadeAnimation.value,
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      'Repayment Overview, Alex',
                      style: TextStyle(
                        fontSize: (size.width > 600 ? 30 : 24) * fontScale,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02 * paddingScale),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      height: cardHeight,
                      width: double.infinity,
                      padding: EdgeInsets.all(size.width * 0.04 * paddingScale),
                      decoration: BoxDecoration(
                        gradient: cardGradient,
                        borderRadius: BorderRadius.circular(24 * scaleFactor),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(0.3),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: accentColor.withOpacity(_glowAnimation.value),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Outstanding Balance',
                                    style: TextStyle(
                                      fontSize: 16 * fontScale,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      shadows: [Shadow(blurRadius: 2, color: Colors.black45)],
                                    ),
                                  ),
                                  AnimatedBuilder(
                                    animation: _twinkleAnimation,
                                    builder: (context, child) {
                                      return Opacity(
                                        opacity: _twinkleAnimation.value,
                                        child: Icon(Icons.account_balance_wallet, color: Colors.white, size: 24 * fontScale),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Due Date: Sep 30, 2025',
                                    style: TextStyle(
                                      fontSize: 14 * fontScale,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '\$1,200',
                                    style: TextStyle(
                                      fontSize: 28 * fontScale,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Pay on time to maintain your credit score',
                                style: TextStyle(
                                  fontSize: 12 * fontScale,
                                  color: Colors.white70,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: _shineAnimation,
                              builder: (context, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24 * scaleFactor),
                                    gradient: LinearGradient(
                                      begin: Alignment(_shineAnimation.value - 1, 0),
                                      end: Alignment(_shineAnimation.value + 1, 0),
                                      colors: [
                                        Colors.transparent,
                                        Colors.white.withOpacity(0.1),
                                        Colors.white.withOpacity(0.2),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03 * paddingScale),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildAnimatedActionCard(
                            label: 'Make Payment',
                            icon: Icons.payment,
                            color: primaryColor,
                            onPressed: () {
                              _handleButtonPress('pay', () {
                                // Navigate to payment page
                              });
                            },
                            isFilled: true,
                            width: buttonWidth,
                            isPressed: _payButtonPressed,
                            continuousAnimation: _pulseAnimation,
                            glowAnimation: _glowAnimation,
                          ),
                          _buildAnimatedActionCard(
                            label: 'Payment History',
                            icon: Icons.history,
                            color: primaryColor,
                            onPressed: () {
                              _handleButtonPress('history', () {
                                // Navigate to payment history page
                              });
                            },
                            isFilled: false,
                            width: buttonWidth,
                            isPressed: _historyPressed,
                            continuousAnimation: null,
                            glowAnimation: null,
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.015 * paddingScale),
                      _buildAnimatedActionButton(
                        label: 'View Payment Plan',
                        icon: Icons.schedule,
                        color: primaryColor,
                        onPressed: () {
                          _handleButtonPress('plan', () {
                            // Navigate to payment plan page
                          });
                        },
                        isFilled: true,
                        width: double.infinity,
                        isPressed: _planPressed,
                        continuousAnimation: _twinkleAnimation,
                        glowAnimation: _glowAnimation,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03 * paddingScale),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                    indent: 20 * paddingScale,
                    endIndent: 20 * paddingScale,
                  ),
                  SizedBox(height: size.height * 0.02 * paddingScale),
                  AnimatedBuilder(
                    animation: _staggerController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: _staggerController,
                            curve: Interval(0.5, 1.0, curve: Curves.easeInOutQuad),
                          ),
                        ).value,
                        child: Transform.translate(
                          offset: Offset(0, Tween<double>(begin: 30.0, end: 0.0).animate(
                            CurvedAnimation(
                              parent: _staggerController,
                              curve: Interval(0.5, 1.0, curve: Curves.easeInOutQuad),
                            ),
                          ).value),
                          child: child,
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'More repayment tools coming soon...',
                        style: TextStyle(
                          fontSize: 14 * fontScale,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey[500],
        showUnselectedLabels: true,
        selectedFontSize: 11 * fontScale,
        unselectedFontSize: 11 * fontScale,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 24 * fontScale), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome, size: 24 * fontScale), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.hub_outlined, size: 24 * fontScale), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border, size: 24 * fontScale), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted_rounded, size: 24 * fontScale), label: 'More'),
        ],
        onTap: (index) {
          HapticFeedback.lightImpact();
          // Add navigation logic with animations
        },
      ),
    );
  }

  Widget _buildAnimatedActionCard({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required bool isFilled,
    required double width,
    required bool isPressed,
    required Animation<double>? continuousAnimation,
    Animation<double>? glowAnimation,
  }) {
    final scaleFactor = MediaQuery.of(context).size.width < 360 ? 0.85 : 1.0;
    final double cardHeight = width * 0.6; // Proportional height
    final cardGradient = LinearGradient(
      colors: isFilled ? [color, color.withOpacity(0.85)] : [Colors.transparent, Colors.transparent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedScale(
            scale: isPressed ? 0.95 : 1.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOutBack,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutQuad,
              width: width,
              height: cardHeight,
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleFactor, vertical: 12 * scaleFactor),
              decoration: BoxDecoration(
                gradient: isFilled ? cardGradient : null,
                border: isFilled ? null : Border.all(color: color, width: 2),
                borderRadius: BorderRadius.circular(20 * scaleFactor),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(isFilled ? 0.5 : 0.2),
                    blurRadius: isFilled ? 8 : 4,
                    offset: Offset(0, isFilled ? 4 : 2),
                    spreadRadius: 1,
                  ),
                  if (glowAnimation != null && isFilled)
                    BoxShadow(
                      color: color.withOpacity(glowAnimation.value),
                      blurRadius: 12,
                      spreadRadius: 3,
                    ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  continuousAnimation != null
                      ? AnimatedBuilder(
                    animation: continuousAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: continuousAnimation.value,
                        child: Icon(icon, color: isFilled ? Colors.white : color, size: 24 * scaleFactor),
                      );
                    },
                  )
                      : Icon(icon, color: isFilled ? Colors.white : color, size: 24 * scaleFactor),
                  SizedBox(width: 12 * scaleFactor),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isFilled ? Colors.white : color,
                        fontSize: 16 * scaleFactor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isPressed)
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                return Container(
                  width: width * _rippleAnimation.value * 1.2,
                  height: cardHeight * _rippleAnimation.value * 1.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.25 * (1 - _rippleAnimation.value)),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required bool isFilled,
    required double width,
    required bool isPressed,
    required Animation<double>? continuousAnimation,
    Animation<double>? glowAnimation,
  }) {
    final scaleFactor = MediaQuery.of(context).size.width < 360 ? 0.85 : 1.0;
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedScale(
            scale: isPressed ? 0.95 : 1.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOutBack,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutQuad,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor, vertical: 14 * scaleFactor),
              decoration: BoxDecoration(
                color: isFilled ? color : Colors.transparent,
                border: isFilled ? null : Border.all(color: color, width: 2),
                borderRadius: BorderRadius.circular(36 * scaleFactor),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(isFilled ? 0.4 : 0.15),
                    blurRadius: isFilled ? 6 : 3,
                    offset: Offset(0, isFilled ? 3 : 1),
                    spreadRadius: 1,
                  ),
                  if (glowAnimation != null)
                    BoxShadow(
                      color: color.withOpacity(glowAnimation.value),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                ],
                gradient: isFilled ? LinearGradient(colors: [color, color.withOpacity(0.85)]) : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  continuousAnimation != null
                      ? AnimatedBuilder(
                    animation: continuousAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: continuousAnimation.value,
                        child: Icon(icon, color: isFilled ? Colors.white : color, size: 22 * scaleFactor),
                      );
                    },
                  )
                      : Icon(icon, color: isFilled ? Colors.white : color, size: 22 * scaleFactor),
                  SizedBox(width: 10 * scaleFactor),
                  Text(
                    label,
                    style: TextStyle(
                      color: isFilled ? Colors.white : color,
                      fontSize: 5 ,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isPressed)
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                return Container(
                  width: width * _rippleAnimation.value * 1.2,
                  height: (50 * scaleFactor) * _rippleAnimation.value * 1.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.25 * (1 - _rippleAnimation.value)),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}