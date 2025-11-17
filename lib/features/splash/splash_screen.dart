import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers.dart';
import '../../widgets/app_logo.dart';
import '../../core/design_system.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(_bootstrap());
  }

  Future<void> _bootstrap() async {
    try {
      // Ensure SharedPreferences ready (with a small timeout in tests)
      await ref
          .read(sharedPreferencesProvider.future)
          .timeout(const Duration(milliseconds: 200));
      // Kick providers to ensure defaults load
      ref.read(categoriesProvider);
      ref.read(transactionsProvider);
      final repo = ref.read(authRepositoryProvider);
      final loggedIn = await (repo?.isLoggedIn() ?? Future.value(false));
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      if (loggedIn) {
        context.go('/app/home');
      } else {
        context.go('/login');
      }
    } catch (_) {
      if (!mounted) return;
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onPrimary = theme.colorScheme.onPrimary;
    return Scaffold(
      body: Stack(
        children: [
          // Layered animated gradient background
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1200),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                    theme.colorScheme.primaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          // Decorative subtle circles
          Positioned(
            top: -80,
            left: -40,
            child: _DecorativeCircle(
              color: Colors.white.withValues(alpha: 0.08),
              size: 240,
            ),
          ),
          Positioned(
            bottom: -100,
            right: -20,
            child: _DecorativeCircle(
              color: Colors.white.withValues(alpha: 0.06),
              size: 300,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLogo(size: 100)
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(
                      begin: 0.15,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOutBack,
                    ),
                const SizedBox(height: Spacing.lg),
                Text(
                      'DanaKu',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: onPrimary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 700.ms)
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      duration: 700.ms,
                      curve: Curves.easeOutCubic,
                    ),
                const SizedBox(height: Spacing.md),
                Text(
                      'Kelola keuanganmu dengan mudah',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: onPrimary.withValues(alpha: .85),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideY(begin: 0.25, end: 0, duration: 800.ms),
                const SizedBox(height: Spacing.xl),
                CircularProgressIndicator(color: onPrimary)
                    .animate()
                    .fadeIn(duration: 900.ms)
                    .slideY(begin: 0.3, end: 0, duration: 900.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(
              color: Colors.white.withValues(alpha: .04),
              width: 2,
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 1200.ms)
        .scale(
          begin: const Offset(.8, .8),
          end: const Offset(1, 1),
          duration: 1500.ms,
        );
  }
}
