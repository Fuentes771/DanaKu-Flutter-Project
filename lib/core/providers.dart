import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/auth_repository.dart';
import '../data/categories_repository.dart';
import '../data/transactions_repository.dart';
import '../data/models/category.dart';
import '../data/models/transaction.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

final authRepositoryProvider = Provider<AuthRepository?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).maybeWhen(
        data: (p) => p,
        orElse: () => null,
      );
  if (prefs == null) return null;
  return AuthRepository(prefs);
});

final categoriesRepositoryProvider = Provider<CategoriesRepository?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).maybeWhen(data: (p) => p, orElse: () => null);
  if (prefs == null) return null;
  return CategoriesRepository(prefs);
});

final transactionsRepositoryProvider = Provider<TransactionsRepository?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).maybeWhen(data: (p) => p, orElse: () => null);
  if (prefs == null) return null;
  return TransactionsRepository(prefs);
});

class CategoriesNotifier extends StateNotifier<AsyncValue<List<AppCategory>>> {
  CategoriesNotifier(this._repo) : super(const AsyncValue.loading());
  final CategoriesRepository _repo;

  Future<void> load() async {
    await _repo.ensureDefaults();
    final items = await _repo.getAll();
    state = AsyncValue.data(items);
  }

  Future<void> add(AppCategory cat) async {
    final current = <AppCategory>[...(state.value ?? const <AppCategory>[])];
    current.add(cat);
    state = AsyncValue.data(current);
    await _repo.saveAll(current);
  }

  Future<void> remove(String id) async {
    final current = <AppCategory>[...(state.value ?? const <AppCategory>[])]
      ..removeWhere((e) => e.id == id);
    state = AsyncValue.data(current);
    await _repo.saveAll(current);
  }
}

final categoriesProvider = StateNotifierProvider<CategoriesNotifier, AsyncValue<List<AppCategory>>>((ref) {
  final repo = ref.watch(categoriesRepositoryProvider);
  if (repo == null) {
    return CategoriesNotifier(FakeCategoriesRepository())..load();
  }
  final notifier = CategoriesNotifier(repo);
  notifier.load();
  return notifier;
});

class TransactionsNotifier extends StateNotifier<AsyncValue<List<AppTransaction>>> {
  TransactionsNotifier(this._repo) : super(const AsyncValue.data(<AppTransaction>[]));
  final TransactionsRepository _repo;

  Future<void> load() async {
    final items = await _repo.getAll();
    state = AsyncValue.data(items);
  }

  Future<void> add(AppTransaction tx) async {
    final current = <AppTransaction>[...(state.value ?? const <AppTransaction>[])];
    current.insert(0, tx);
    state = AsyncValue.data(current);
    await _repo.saveAll(current);
  }

  Future<void> remove(String id) async {
    final current = <AppTransaction>[...(state.value ?? const <AppTransaction>[])]
      ..removeWhere((e) => e.id == id);
    state = AsyncValue.data(current);
    await _repo.saveAll(current);
  }

  Future<void> update(AppTransaction tx) async {
    final current = <AppTransaction>[...(state.value ?? const <AppTransaction>[])];
    final idx = current.indexWhere((e) => e.id == tx.id);
    if (idx >= 0) {
      current[idx] = tx;
      state = AsyncValue.data(current);
      await _repo.saveAll(current);
    }
  }
}

final transactionsProvider = StateNotifierProvider<TransactionsNotifier, AsyncValue<List<AppTransaction>>>((ref) {
  final repo = ref.watch(transactionsRepositoryProvider);
  if (repo == null) {
    return TransactionsNotifier(FakeTransactionsRepository())..load();
  }
  final notifier = TransactionsNotifier(repo);
  notifier.load();
  return notifier;
});

// Simple in-memory fallbacks to avoid null repos in early boot (tests/dev)
class FakeCategoriesRepository extends CategoriesRepository {
  FakeCategoriesRepository() : super(_FakePrefs());
}

class FakeTransactionsRepository extends TransactionsRepository {
  FakeTransactionsRepository() : super(_FakePrefs());
}

class _FakePrefs implements SharedPreferences {
  final Map<String, Object> _data = {};

  @override
  String? getString(String key) => _data[key] as String?;

  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }

  @override
  bool? getBool(String key) => _data[key] as bool?;

  @override
  Future<bool> setBool(String key, bool value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
