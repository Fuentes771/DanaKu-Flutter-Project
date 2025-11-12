import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'models/category.dart';
import 'interfaces.dart';

class CategoriesRepository implements ICategoriesRepository {
  CategoriesRepository(this._prefs);

  final SharedPreferences _prefs;
  static const _key = 'repo_categories_v1';

  @override
  Future<List<AppCategory>> getAll() async {
    final raw = _prefs.getString(_key);
    if (raw == null) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(AppCategory.fromJson).toList();
  }

  @override
  Future<void> saveAll(List<AppCategory> categories) async {
    final raw = jsonEncode(categories.map((e) => e.toJson()).toList());
    await _prefs.setString(_key, raw);
  }

  @override
  Future<void> ensureDefaults() async {
    final existing = await getAll();
    if (existing.isNotEmpty) return;
    final defaults = <AppCategory>[
      AppCategory(id: 'exp_food', name: 'Makanan', type: CategoryType.expense),
      AppCategory(id: 'exp_transport', name: 'Transportasi', type: CategoryType.expense),
      AppCategory(id: 'exp_shopping', name: 'Belanja', type: CategoryType.expense),
      AppCategory(id: 'inc_salary', name: 'Gaji', type: CategoryType.income),
      AppCategory(id: 'inc_other', name: 'Lainnya', type: CategoryType.income),
    ];
    await saveAll(defaults);
  }
}
