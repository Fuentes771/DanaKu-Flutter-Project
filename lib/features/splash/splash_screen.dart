import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers.dart';

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
      await ref.read(sharedPreferencesProvider.future).timeout(const Duration(milliseconds: 200));
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.account_balance_wallet, size: 72, color: onPrimary).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 16),
              Text('DanaKu', style: theme.textTheme.headlineMedium?.copyWith(color: onPrimary, fontWeight: FontWeight.w800))
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, end: 0, duration: 400.ms),
              const SizedBox(height: 24),
              CircularProgressIndicator(color: onPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
