import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Semantic finance colors (income, expense, warning) exposed via ThemeExtension.
class FinanceColors extends ThemeExtension<FinanceColors> {
  final Color income;
  final Color expense;
  final Color warning;
  final Color accentGradientStart;
  final Color accentGradientEnd;

  const FinanceColors({
    required this.income,
    required this.expense,
    required this.warning,
    required this.accentGradientStart,
    required this.accentGradientEnd,
  });

  @override
  FinanceColors copyWith({
    Color? income,
    Color? expense,
    Color? warning,
    Color? accentGradientStart,
    Color? accentGradientEnd,
  }) => FinanceColors(
    income: income ?? this.income,
    expense: expense ?? this.expense,
    warning: warning ?? this.warning,
    accentGradientStart: accentGradientStart ?? this.accentGradientStart,
    accentGradientEnd: accentGradientEnd ?? this.accentGradientEnd,
  );

  @override
  ThemeExtension<FinanceColors> lerp(
    ThemeExtension<FinanceColors>? other,
    double t,
  ) {
    if (other is! FinanceColors) return this;
    return FinanceColors(
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      accentGradientStart: Color.lerp(
        accentGradientStart,
        other.accentGradientStart,
        t,
      )!,
      accentGradientEnd: Color.lerp(
        accentGradientEnd,
        other.accentGradientEnd,
        t,
      )!,
    );
  }
}

ThemeData buildLightTheme() {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0BA28A),
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );
  final textTheme = GoogleFonts.poppinsTextTheme(base.textTheme);
  return base.copyWith(
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: base.colorScheme.surface,
      foregroundColor: base.colorScheme.onSurface,
      centerTitle: false,
      elevation: 0,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: base.colorScheme.surfaceContainerHighest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: base.colorScheme.surface,
      indicatorColor: base.colorScheme.primaryContainer,
      labelTextStyle: WidgetStateProperty.all(
        textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    extensions: const [
      FinanceColors(
        income: Color(0xFF079B4B),
        expense: Color(0xFFDA3D2A),
        warning: Color(0xFFF2A438),
        accentGradientStart: Color(0xFF0BA28A),
        accentGradientEnd: Color(0xFF4DD2B9),
      ),
    ],
  );
}

ThemeData buildDarkTheme() {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0BA28A),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
  final textTheme = GoogleFonts.poppinsTextTheme(base.textTheme);
  return base.copyWith(
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: base.colorScheme.surface,
      foregroundColor: base.colorScheme.onSurface,
      centerTitle: false,
      elevation: 0,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: base.colorScheme.surfaceContainerHighest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: base.colorScheme.surface,
      indicatorColor: base.colorScheme.primaryContainer,
      labelTextStyle: WidgetStateProperty.all(
        textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    extensions: const [
      FinanceColors(
        income: Color(0xFF4DD2A1),
        expense: Color(0xFFFF6B55),
        warning: Color(0xFFFFC76A),
        accentGradientStart: Color(0xFF0BA28A),
        accentGradientEnd: Color(0xFF117866),
      ),
    ],
  );
}
