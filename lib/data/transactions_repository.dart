import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'models/transaction.dart';

class TransactionsRepository {
  TransactionsRepository(this._prefs);

  final SharedPreferences _prefs;
  static const _key = 'repo_transactions_v1';

  Future<List<AppTransaction>> getAll() async {
    final raw = _prefs.getString(_key);
    if (raw == null) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(AppTransaction.fromJson).toList();
  }

  Future<void> saveAll(List<AppTransaction> txs) async {
    final raw = jsonEncode(txs.map((e) => e.toJson()).toList());
    await _prefs.setString(_key, raw);
  }
}
