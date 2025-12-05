import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the financial application.
class AppTheme {
  AppTheme._();

  // Dark Wealth Color Palette - Optimized for OLED displays and financial trust
  static const Color primaryDark =
      Color(0xFF1a1a1a); // Deep charcoal background
  static const Color secondaryDark =
      Color(0xFF2d2d2d); // Elevated surface color
  static const Color accentGold = Color(0xFF9e814e); // Premium gold for CTAs
  static const Color successGreen =
      Color(0xFF4ade80); // Clean green for positive indicators
  static const Color warningAmber = Color(0xFFfbbf24); // Amber for alerts
  static const Color errorRed =
      Color(0xFFef4444); // Clear red for critical actions
  static const Color textPrimary =
      Color(0xFFffffff); // Pure white for primary content
  static const Color textSecondary =
      Color(0xFFa1a1aa); // Muted gray for supporting info
  static const Color borderGray =
      Color(0xFF374151); // Subtle gray for divisions
  static const Color surfaceModal =
      Color(0xFF111827); // Modal and overlay background

  static const Color primaryGold = Color(0xFF9e814e);
  static const Color deepCharcoal = Color(0xFF1a1a1a);
  static const Color elevatedSurface = Color(0xFF2d2d2d);
  static const Color trueDarkBackground = Color(0xFF0f0f0f);
  static const Color infoBlue = Color(0xFF60a5fa);

  static const Color backgroundDark = Color(0xFF1a1a1a);
  static const Color surfaceDark = Color(0xFF2d2d2d); // Elevated card surfaces
  static const Color surfaceLight = Color(0xFFffffff); // Light surface
  static const Color backgroundLight = Color(0xFFf8f8f8);
  static const Color neutralGray = Color(0xFF666666);
  static const Color primaryGoldVariant = Color(0xFF7a6439);
  static const Color accentBlue = Color(0xFF4285f4);
  static const Color warningOrange = Color(0xFFff8800);
  static const Color dividerLight = Color(0x1F000000);
  static const Color dividerDark = Color(0x1Fffffff);
  static const Color dialogDark = Color(0xFF2d2d2d);

  static const Color primaryCharcoal = Color(0xFF1A1A1A);
  static const Color chronosGold = Color(0xFF9E814E);
  static const Color textTertiary = Color(0xFF808080);
  static const Color dividerSubtle = Color(0xFF333333);

  // Light theme colors (for potential future use or system preference)
  static const Color primaryLight = Color(0xFFf8fafc);
  static const Color secondaryLight = Color(0xFFe2e8f0);
  static const Color accentGoldLight = Color(0xFF9e814e);
  static const Color successGreenLight = Color(0xFF22c55e);
  static const Color warningAmberLight = Color(0xFFf59e0b);
  static const Color errorRedLight = Color(0xFFdc2626);
  static const Color textPrimaryLight = Color(0xFF0f172a);
  static const Color textSecondaryLight = Color(0xFF64748b);
  static const Color borderGrayLight = Color(0xFFe2e8f0);
  static const Color surfaceModalLight = Color(0xFFffffff);

  // Shadow colors optimized for dark theme
  static const Color shadowDark = Color(0x40000000);
  static const Color shadowLight = Color(0x1a000000);

  /// Dark theme - Primary theme for financial application
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: accentGold,
      onPrimary: primaryDark,
      primaryContainer: accentGold.withValues(alpha: 0.2),
      onPrimaryContainer: textPrimary,
      secondary: secondaryDark,
      onSecondary: textPrimary,
      secondaryContainer: secondaryDark.withValues(alpha: 0.8),
      onSecondaryContainer: textPrimary,
      tertiary: successGreen,
      onTertiary: primaryDark,
      tertiaryContainer: successGreen.withValues(alpha: 0.2),
      onTertiaryContainer: textPrimary,
      error: errorRed,
      onError: textPrimary,
      surface: primaryDark,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      outline: borderGray,
      outlineVariant: borderGray.withValues(alpha: 0.5),
      shadow: shadowDark,
      scrim: shadowDark,
      inverseSurface: surfaceModalLight,
      onInverseSurface: textPrimaryLight,
      inversePrimary: accentGoldLight,
    ),
    scaffoldBackgroundColor: primaryDark,
    cardColor: secondaryDark,
    dividerColor: borderGray,

    // AppBar theme for financial trust and clarity
    appBarTheme: AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        letterSpacing: 0.15,
      ),
      iconTheme: const IconThemeData(
        color: textPrimary,
        size: 24,
      ),
    ),

    // Card theme for modular content blocks
    // cardTheme: CardTheme(
    //   color: secondaryDark,
    //   elevation: 2.0,
    //   shadowColor: shadowDark,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12.0),
    //   ),
    //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    // ),

    // Bottom navigation optimized for one-handed operation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: secondaryDark,
      selectedItemColor: accentGold,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 4,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating action button for contextual actions
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentGold,
      foregroundColor: primaryDark,
      elevation: 4,
      focusElevation: 6,
      hoverElevation: 6,
      highlightElevation: 8,
      shape: CircleBorder(),
    ),

    // Elevated button theme for primary actions
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: primaryDark,
        backgroundColor: accentGold,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
      ),
    ),

    // Outlined button theme for secondary actions
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentGold,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: accentGold, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),

    // Text button theme for tertiary actions
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentGold,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),

    // Text theme using Inter font family for consistency
    textTheme: _buildTextTheme(isLight: false),

    // Input decoration theme for forms and biometric prompts
    inputDecorationTheme: InputDecorationTheme(
      fillColor: secondaryDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: borderGray, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: borderGray, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: accentGold, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textSecondary.withValues(alpha: 0.7),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      prefixIconColor: textSecondary,
      suffixIconColor: textSecondary,
    ),

    // Switch theme for settings and toggles
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentGold;
        }
        return textSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentGold.withValues(alpha: 0.3);
        }
        return borderGray;
      }),
    ),

    // Checkbox theme for selection states
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentGold;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(primaryDark),
      side: const BorderSide(color: borderGray, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),

    // Radio theme for single selection
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentGold;
        }
        return borderGray;
      }),
    ),

    // Progress indicator theme for loading states
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: accentGold,
      linearTrackColor: borderGray,
      circularTrackColor: borderGray,
    ),

    // Slider theme for value selection
    sliderTheme: SliderThemeData(
      activeTrackColor: accentGold,
      thumbColor: accentGold,
      overlayColor: accentGold.withValues(alpha: 0.2),
      inactiveTrackColor: borderGray,
      valueIndicatorColor: accentGold,
      valueIndicatorTextStyle: GoogleFonts.jetBrainsMono(
        color: primaryDark,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Tab bar theme for navigation
    // tabBarTheme: TabBarTheme(
    //   labelColor: accentGold,
    //   unselectedLabelColor: textSecondary,
    //   indicatorColor: accentGold,
    //   indicatorSize: TabBarIndicatorSize.label,
    //   labelStyle: GoogleFonts.inter(
    //     fontSize: 14,
    //     fontWeight: FontWeight.w600,
    //     letterSpacing: 0.1,
    //   ),
    //   unselectedLabelStyle: GoogleFonts.inter(
    //     fontSize: 14,
    //     fontWeight: FontWeight.w400,
    //     letterSpacing: 0.1,
    //   ),
    // ),

    // Tooltip theme for helpful information
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: surfaceModal,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderGray, width: 1),
      ),
      textStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // SnackBar theme for notifications
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceModal,
      contentTextStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentGold,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
    ),

    // Dialog theme for modals and alerts
    // dialogTheme: DialogTheme(
    //   backgroundColor: surfaceModal,
    //   elevation: 8,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(16.0),
    //   ),
    //   titleTextStyle: GoogleFonts.inter(
    //     color: textPrimary,
    //     fontSize: 20,
    //     fontWeight: FontWeight.w600,
    //     letterSpacing: 0.15,
    //   ),
    //   contentTextStyle: GoogleFonts.inter(
    //     color: textSecondary,
    //     fontSize: 14,
    //     fontWeight: FontWeight.w400,
    //     letterSpacing: 0.25,
    //   ),
    // ),

    // List tile theme for menu items
    listTileTheme: ListTileThemeData(
      tileColor: Colors.transparent,
      selectedTileColor: accentGold.withValues(alpha: 0.1),
      iconColor: textSecondary,
      textColor: textPrimary,
      selectedColor: accentGold,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),

    // Chip theme for tags and filters
    chipTheme: ChipThemeData(
      backgroundColor: secondaryDark,
      selectedColor: accentGold.withValues(alpha: 0.2),
      disabledColor: borderGray,
      labelStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );

  /// Light theme - Alternative theme for system preference
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: accentGoldLight,
      onPrimary: primaryLight,
      primaryContainer: accentGoldLight.withValues(alpha: 0.1),
      onPrimaryContainer: textPrimaryLight,
      secondary: secondaryLight,
      onSecondary: textPrimaryLight,
      secondaryContainer: secondaryLight.withValues(alpha: 0.5),
      onSecondaryContainer: textPrimaryLight,
      tertiary: successGreenLight,
      onTertiary: primaryLight,
      tertiaryContainer: successGreenLight.withValues(alpha: 0.1),
      onTertiaryContainer: textPrimaryLight,
      error: errorRedLight,
      onError: primaryLight,
      surface: primaryLight,
      onSurface: textPrimaryLight,
      onSurfaceVariant: textSecondaryLight,
      outline: borderGrayLight,
      outlineVariant: borderGrayLight.withValues(alpha: 0.5),
      shadow: shadowLight,
      scrim: shadowLight,
      inverseSurface: primaryDark,
      onInverseSurface: textPrimary,
      inversePrimary: accentGold,
    ),
    scaffoldBackgroundColor: primaryLight,
    cardColor: surfaceModalLight,
    dividerColor: borderGrayLight,

    // Similar theme configurations as dark theme but with light colors
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      foregroundColor: textPrimaryLight,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimaryLight,
        letterSpacing: 0.15,
      ),
      iconTheme: const IconThemeData(
        color: textPrimaryLight,
        size: 24,
      ),
    ),

    // cardTheme: CardTheme(
    //   color: surfaceModalLight,
    //   elevation: 2.0,
    //   shadowColor: shadowLight,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12.0),
    //   ),
    //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    // ),

    textTheme: _buildTextTheme(isLight: true),
    dialogTheme: DialogThemeData(backgroundColor: surfaceModalLight),

    // Additional light theme configurations would follow similar pattern
  );

  /// Helper method to build text theme with Inter and JetBrains Mono fonts
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHigh = isLight ? textPrimaryLight : textPrimary;
    final Color textMedium = isLight ? textSecondaryLight : textSecondary;
    final Color textDisabled = isLight
        ? textSecondaryLight.withValues(alpha: 0.6)
        : textSecondary.withValues(alpha: 0.6);

    return TextTheme(
      // Display styles for large headings
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textHigh,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textHigh,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textHigh,
      ),

      // Headline styles for section headers
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textHigh,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textHigh,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textHigh,
      ),

      // Title styles for card headers and important text
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textHigh,
        letterSpacing: 0.15,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textHigh,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHigh,
        letterSpacing: 0.1,
      ),

      // Body styles for main content
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHigh,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHigh,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMedium,
        letterSpacing: 0.4,
      ),

      // Label styles for buttons and small text
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHigh,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMedium,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textDisabled,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Helper method to get monospace text style for financial data
  static TextStyle getMonospaceStyle({
    required bool isLight,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
  }) {
    final Color defaultColor =
        color ?? (isLight ? textPrimaryLight : textPrimary);

    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: defaultColor,
      letterSpacing: 0.25,
    );
  }

  /// Helper method to get accent color variations
  static Color getAccentVariation(double opacity) {
    return accentGold.withValues(alpha: opacity);
  }

  /// Helper method to get success color variations
  static Color getSuccessVariation(double opacity) {
    return successGreen.withValues(alpha: opacity);
  }

  /// Helper method to get error color variations
  static Color getErrorVariation(double opacity) {
    return errorRed.withValues(alpha: opacity);
  }

  /// Helper method to get warning color variations
  static Color getWarningVariation(double opacity) {
    return warningAmber.withValues(alpha: opacity);
  }

  static BoxDecoration glassmorphicDecoration({
    double borderRadius = 12.0,
    double opacity = 0.1,
  }) {
    return BoxDecoration(
      color: textPrimary.withValues(alpha: opacity),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: textPrimary.withValues(alpha: 0.2),
        width: 1,
      ),
    );
  }

  static List<BoxShadow> elevationShadow(int elevation) {
    switch (elevation) {
      case 2:
        return [
          BoxShadow(
            color: shadowDark,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ];
      case 4:
        return [
          BoxShadow(
            color: shadowDark,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ];
      case 8:
        return [
          BoxShadow(
            color: shadowDark,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ];
      default:
        return [];
    }
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
      case 'completed':
      case 'confirmed':
        return successGreen;
      case 'warning':
      case 'pending':
      case 'processing':
        return warningAmber;
      case 'error':
      case 'failed':
      case 'rejected':
        return errorRed;
      case 'info':
      case 'neutral':
      default:
        return infoBlue;
    }
  }

  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration standardAnimation = Duration(milliseconds: 300);
  static const Duration aiAnimation = Duration(milliseconds: 400);

  static TextStyle get financialDataLarge => GoogleFonts.robotoMono(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: textPrimary,
      letterSpacing: 0);

  static TextStyle get financialDataMedium => GoogleFonts.robotoMono(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: textPrimary,
      letterSpacing: 0);

  static TextStyle get financialDataSmall => GoogleFonts.robotoMono(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: textSecondary,
      letterSpacing: 0);

  static const double elevationResting = 2.0;
  static const double elevationHovered = 4.0;
  static const double elevationPressed = 6.0;
  static const double elevationFocused = 8.0;
}
