import 'models/category.dart';
import 'models/transaction.dart';

abstract class IAuthRepository {
  Future<bool> isLoggedIn();
  Future<void> login({required String email, required String password});
  Future<void> register({required String email, required String password});
  Future<void> logout();
  String? get userId;
}

abstract class ICategoriesRepository {
  Future<List<AppCategory>> getAll();
  Future<void> saveAll(List<AppCategory> categories);
  Future<void> ensureDefaults();
}

abstract class ITransactionsRepository {
  Future<List<AppTransaction>> getAll();
  Future<void> saveAll(List<AppTransaction> txs);
}
