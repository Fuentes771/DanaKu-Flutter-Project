import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_manajemenkeuangan/features/transactions/transactions_screen.dart';
import 'package:flutter_manajemenkeuangan/core/providers.dart';
import 'package:flutter_manajemenkeuangan/data/models/transaction.dart';
import 'package:flutter_manajemenkeuangan/data/models/category.dart';

void main() {
  testWidgets('Category filter reduces visible transactions', (tester) async {
    Intl.defaultLocale = 'id_ID';
    await initializeDateFormatting('id_ID');
    final catFood = AppCategory(
      id: 'c1',
      name: 'Makan',
      type: CategoryType.expense,
    );
    final catSalary = AppCategory(
      id: 'c2',
      name: 'Gaji',
      type: CategoryType.income,
    );

    final txFood = AppTransaction(
      id: 't1',
      amount: 15000,
      type: TransactionType.expense,
      categoryId: 'c1',
      date: DateTime.now(),
      note: 'Nasi goreng',
    );
    final txSalary = AppTransaction(
      id: 't2',
      amount: 1000000,
      type: TransactionType.income,
      categoryId: 'c2',
      date: DateTime.now(),
      note: 'Gaji Bulanan',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          categoriesProvider.overrideWith((ref) {
            final n = CategoriesNotifier(FakeCategoriesRepository());
            n.state = AsyncValue.data([catFood, catSalary]);
            return n;
          }),
          transactionsProvider.overrideWith((ref) {
            final n = TransactionsNotifier(FakeTransactionsRepository());
            n.state = AsyncValue.data([txFood, txSalary]);
            return n;
          }),
        ],
        child: const MaterialApp(home: TransactionsScreen()),
      ),
    );

    await tester.pumpAndSettle();

    // Both transactions should be visible by default
    expect(find.text('Nasi goreng'), findsOneWidget);
    expect(find.text('Gaji Bulanan'), findsOneWidget);

    // Open category dropdown and select 'Makan'
    final dropdown = find.byType(DropdownButtonFormField<String?>).first;
    await tester.tap(dropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Makan').last);
    await tester.pumpAndSettle();

    // Now only the expense transaction should be visible
    expect(find.text('Nasi goreng'), findsOneWidget);
    expect(find.text('Gaji Bulanan'), findsNothing);
  });
}
