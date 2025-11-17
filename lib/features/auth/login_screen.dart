import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers.dart';
import '../../widgets/brand_background.dart';
import '../../widgets/app_logo.dart';
import '../../core/design_system.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo?.login(email: _emailCtrl.text, password: _passwordCtrl.text);
      // Refresh data providers to rebind to the correct backend (e.g., Firebase)
      ref.invalidate(categoriesProvider);
      ref.invalidate(transactionsProvider);
      if (!mounted) return;
      context.go('/app/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login gagal: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: BrandBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppLogo(size: 84),
                  const SizedBox(height: Spacing.md),
                  Text('Selamat datang kembali',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700)),
                  const SizedBox(height: Spacing.lg),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 420),
                    padding: const EdgeInsets.all(Spacing.lg),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .15), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _emailCtrl,
                            decoration: const InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) => (v == null || v.isEmpty) ? 'Email wajib diisi' : null,
                          ),
                          const SizedBox(height: Spacing.md),
                          TextFormField(
                            controller: _passwordCtrl,
                            decoration: const InputDecoration(labelText: 'Kata sandi'),
                            obscureText: true,
                            validator: (v) => (v == null || v.length < 4) ? 'Minimal 4 karakter' : null,
                          ),
                          const SizedBox(height: Spacing.lg),
                          FilledButton(
                            onPressed: _loading ? null : _submit,
                            child: _loading ? const CircularProgressIndicator() : const Text('Masuk'),
                          ),
                          TextButton(
                            onPressed: () => context.push('/forgot'),
                            child: const Text('Lupa kata sandi?'),
                          ),
                          TextButton(
                            onPressed: () => context.push('/register'),
                            child: const Text('Daftar akun baru'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
